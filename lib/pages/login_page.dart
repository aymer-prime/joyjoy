import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_icon.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/userinfo_model.dart';
import 'package:tryt/pages/activation_page.dart';
import 'package:tryt/pages/password_reset_page.dart';
import 'package:tryt/pages/swiper_page.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../language_pop_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  late bool obscureTextStatus = true;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = Config()
        .getTextSpansFromHtml(Config.langFulText.login!.privacyPolicyText!);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close the keyboard on tap outside
        },
        child: Stack(
          children: [
            SafeArea(
              minimum: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Text(
                    Config.langFulText.login!.title!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mukta(
                      fontSize: 32,
                      height: 1.1,
                      color: ThemeColors.getColorTheme(Config.themType)["color10"],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    Config.langFulText.login!.subtitle!,
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
                          controller: userEmail,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Config.langFulText.login!.errorMessage!
                                  .emailUsername!.wrong
                                  .toString();
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: Config.langFulText.login!.emailUsername!,
                          ),
                          style: GoogleFonts.firaSans(
                            fontSize: 16,
                            color:
                                ThemeColors.getColorTheme(Config.themType)["color10"],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: userPassword,
                          obscureText: obscureTextStatus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Config
                                  .langFulText.login!.errorMessage!.password!.wrong
                                  .toString();
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: Config.langFulText.login!.password,
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextStatus = !obscureTextStatus;
                                });
                              },
                              icon: Icon(
                                (obscureTextStatus)
                                    ? FontAwesome5.eye_slash
                                    : FontAwesome5.eye,
                                color: ThemeColors.getColorTheme(
                                    Config.themType)["color10"],
                              ),
                            ),
                          ),
                          style: GoogleFonts.firaSans(
                            fontSize: 16,
                            color:
                                ThemeColors.getColorTheme(Config.themType)["color10"],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        ButtonText(
                          onpress: () async {
                            if (_formKey.currentState!.validate()) {
                              getLogin();
                            }
                          },
                          btnText: Config.langFulText.login!.button!,
                          bgColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"]!,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ButtonIcon(
                    colorborder1:
                        ThemeColors.getColorTheme(Config.themType)["colorborder1"]!,
                    btnText: Config.langFulText.login!.googleButton!,
                    bgColor: ThemeColors.getColorTheme(Config.themType)["color1"]!,
                    textColor: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                    onpress: () async {
                      _googleLogin();
                    },
                    btnIcon: Image.asset(
                      "assets/images/google-g-icon.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ButtonIcon(
                    colorborder1:
                        ThemeColors.getColorTheme(Config.themType)["colorborder1"]!,
                    btnText: Config.langFulText.login!.emailButton!,
                    bgColor: ThemeColors.getColorTheme(Config.themType)["color1"]!,
                    textColor: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                    onpress: () {
                      Navigator.of(context).pushNamed("/loginpage");
                    },
                    btnIcon: Icon(
                      Icons.mail,
                      color: ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PasswordResetPage()));
                    },
                    child: Text(
                      Config.langFulText.login!.forgotPassword!,
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: ThemeColors.getColorTheme(Config.themType)["color10"],
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
                        color: ThemeColors.getColorTheme(Config.themType)["color5"],
                        fontSize: 12.8,
                        fontWeight: FontWeight.w400,
                      ),
                      children: spans,
                    ),
                  ),
                ],
              ),
            ),
            LanguagePopMenu()
          ],
        ),
      ),
    );
  }

  getLogin() async {
    Config.genelModal(context, const LoadingModal());
    var data = {
      "email_username": userEmail.text,
      "password": userPassword.text,
      "lang": "tr"
    };
    var sonuc = await Httpservices().postMethod("login/index.php", data);
    var body = json.decode(sonuc);
    var deger = body["result"];
    if (body["success"]) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      var data = Userinfomodel.fromJson(deger);
      setState(() {
        Config.userBilgi = data;
      });
      await PrefService().setString("email", userEmail.text);
      await PrefService().setString("password", userPassword.text);
      if (body["result"]["page"] == "activation") {
        Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => ActivationPage(
              email: userEmail.text.toString(),
              password: userPassword.text.toString(),
            ),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (body["result"]["page"] == "info") {
        Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => SwiperPage(
              email: userEmail.text.toString(),
              password: userPassword.text.toString(),
            ),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    } else {
      Navigator.pop(context);
      Config.genelModal(
        // ignore: use_build_context_synchronously
        context,
        AlertBox(
            alertIcon: Icons.priority_high,
            alertColor:
                ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
            title: Config.langFulText.general!.error!,
            content: body["message"],
            btnText: Config.langFulText.general!.okay!),
      );
    }
  }

  void _googleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      await googleSignIn.signOut();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        print('Email: ${account.email}');
        print('Name: ${account.displayName}');
        print('ID: ${account.id}');
        print('Photo URL: ${account.photoUrl}');
        int currentTimeInSeconds =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;
        String hash = Config().generateHash(
            account.email,
            account.displayName.toString(),
            currentTimeInSeconds.toString(),
            account.id);
        print(hash);
        //insert
        //login
      } else {
        // Kullanıcı girişi iptal edildi
        print('Kullanıcı girişi iptal edildi.');
      }
    } catch (error) {
      print('Hata: $error');
    }
  }
}
