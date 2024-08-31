import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/pages/activation_page.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/services/prefservice.dart';

import '../components/language_pop_menu.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  late bool obscureTextStatus = true;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = Config()
        .getTextSpansFromHtml(Config.langFulText.login!.privacyPolicyText!);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Config.langFulText.register!.title!,
                  style: GoogleFonts.mukta(
                    fontSize: 32,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  Config.langFulText.register!.subtitle!,
                  style: GoogleFonts.firaSans(
                    fontSize: 16,
                    color: ThemeColors.getColorTheme(Config.themType)["color7"],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: userName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Config.langFulText.register!.errorMessage!
                                .username!.wrong!;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          fillColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          filled: true,
                          hintText: Config.langFulText.register!.username!,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: userEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Config.langFulText.register!.errorMessage!
                                .email!.wrong!;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          fillColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          filled: true,
                          hintText: Config.langFulText.register!.email!,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: userPassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Config.langFulText.register!.errorMessage!
                                .password!.wrong!;
                          }
                          return null;
                        },
                        obscureText: obscureTextStatus,
                        decoration: InputDecoration(
                          hintText: Config.langFulText.register!.password!,
                          focusColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          fillColor: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureTextStatus = !obscureTextStatus;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["color10"],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ButtonText(
                        onpress: () {
                          if (_formKey.currentState!.validate()) {
                            getCreateUser();
                          }
                        },
                        btnText: Config.langFulText.register!.button!,
                        bgColor: ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"]!,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/login");
                  },
                  child: Text(
                    Config.langFulText.register!.membership!,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.firaSans(
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color5"],
                      fontSize: 12.8,
                      fontWeight: FontWeight.w400,
                    ),
                    children: spans,
                  ),
                ),
              ],
            ),
          ),
          LanguagePopMenu(),
        ],
      ),
    );
  }

  getCreateUser() async {
    Config.genelModal(context, const LoadingModal());
    var token = await PrefService().getString("fcm");
    var data = {
      "email": userEmail.text,
      "password": userPassword.text,
      "username": userName.text,
      "lang": "tr",
      'firebase_token': token,
    };
    var sonuc = await Httpservices().postMethod("login/register.php", data);
    var body = json.decode(sonuc);
    if (body["success"]) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ActivationPage(
            email: userEmail.text.toString(),
            password: userPassword.text.toString(),
          ),
        ),
        (Route<dynamic> route) => false,
      );
      // Navigator.of(context)
      //   .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      Config.genelModal(
        context,
        AlertBox(
          alertIcon: Icons.priority_high,
          alertColor:
              ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
          title: Config.langFulText.general!.error!,
          content: body["message"],
          btnText: "TAMAM",
        ),
      );
    }
  }
}
