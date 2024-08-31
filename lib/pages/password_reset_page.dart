import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/components/language_pop_menu.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  Config.langFulText.forgotPassword!.pageTitle!,
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
                  Config.langFulText.forgotPassword!.subtitle!,
                  style: GoogleFonts.firaSans(
                    height: 1.3,
                    color: ThemeColors.getColorTheme(Config.themType)["color7"],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: userEmail,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: Config.langFulText.forgotPassword!.emailUsername!,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ButtonText(
                  onpress: () async {
                    Config.genelModal(context, const LoadingModal());
                    var data = {"email_username": userEmail.text, "lang": "tr"};
                    var sonuc = await Httpservices()
                        .postMethod("login/forgot-password.php", data);
                    var body = json.decode(sonuc);
                    Navigator.pop(context);
                    Config.genelModal(
                      // ignore: use_build_context_synchronously
                      context,
                      AlertBox(
                          alertIcon:
                              (body["success"]) ? Icons.check : Icons.priority_high,
                          alertColor: (body["success"])
                              ? ThemeColors.getColorTheme(
                                  Config.themType)["colorsuccess"]!
                              : ThemeColors.getColorTheme(
                                  Config.themType)["colordanger"]!,
                          title: (body["success"])
                              ? Config.langFulText.general!.success!
                              : Config.langFulText.general!.error!,
                          content: body["message"],
                          btnText: Config.langFulText.general!.okay!),
                    );
                  },
                  btnText: Config.langFulText.forgotPassword!.button!,
                  bgColor:
                      ThemeColors.getColorTheme(Config.themType)["colorprimary"]!,
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    Config.langFulText.forgotPassword!.login!,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                  ),
                ),
              ],
            ),
          ),
          LanguagePopMenu()
        ],
      ),
    );
  }
}
