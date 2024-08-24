import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordEditPage extends StatefulWidget {
  const PasswordEditPage({super.key});

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController mevcut = TextEditingController();
  final TextEditingController yeni = TextEditingController();
  final TextEditingController tekrar = TextEditingController();
  bool obscureTextStatus = true,
      obscureTextStatus1 = true,
      obscureTextStatus2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor:
              ThemeColors.getColorTheme(Config.themType)["color1"],
          backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
          centerTitle: true,
          title: Text(
            Config.langFulText.profile!.editPassword!.pageTitle!,
            style: GoogleFonts.mukta(
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontWeight: FontWeight.w800,
              fontSize: 23,
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: mevcut,
            obscureText: obscureTextStatus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Config.langFulText.login!.errorMessage!.password!.wrong
                    .toString();
              }
              return null;
            },
            decoration: InputDecoration(
              hintText:
                  Config.langFulText.profile!.editPassword!.currentPassword!,
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
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            style: GoogleFonts.firaSans(
              fontSize: 16,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: yeni,
            obscureText: obscureTextStatus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Config.langFulText.login!.errorMessage!.password!.wrong
                    .toString();
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: Config.langFulText.profile!.editPassword!.newPassword!,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureTextStatus1 = !obscureTextStatus1;
                  });
                },
                icon: Icon(
                  (obscureTextStatus1)
                      ? FontAwesome5.eye_slash
                      : FontAwesome5.eye,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            style: GoogleFonts.firaSans(
              fontSize: 16,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: tekrar,
            obscureText: obscureTextStatus2,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Config.langFulText.login!.errorMessage!.password!.wrong
                    .toString();
              }
              return null;
            },
            decoration: InputDecoration(
              hintText:
                  Config.langFulText.profile!.editPassword!.newPasswordAgain!,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureTextStatus2 = !obscureTextStatus2;
                  });
                },
                icon: Icon(
                  (obscureTextStatus2)
                      ? FontAwesome5.eye_slash
                      : FontAwesome5.eye,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            style: GoogleFonts.firaSans(
              fontSize: 16,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonText(
            onpress: () async {
              kaydet();
            },
            btnText: Config.langFulText.general!.save!,
            bgColor:
                ThemeColors.getColorTheme(Config.themType)["colorprimary"]!,
            textColor: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  kaydet() async {
    var data = {
      "user_id": Config.userBilgi.userId,
      "token": Config.userBilgi.token,
      "lang": Config.lang,
      "current_password": mevcut.text,
      "new_password": yeni.text,
      "new_password_again": tekrar.text,
    };
    var sonuc =
        await Httpservices().postMethod("profile/edit-password.php", data);
    var body = json.decode(sonuc);
    if (body["success"]) {
      themeController.getMyuser();
    }
    Config.genelModal(
      // ignore: use_build_context_synchronously
      context,
      AlertBox(
          alertIcon: (body["success"]) ? Icons.check : Icons.priority_high,
          alertColor: (body["success"])
              ? ThemeColors.getColorTheme(Config.themType)["colorsuccess"]!
              : ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
          title: (body["success"])
              ? Config.langFulText.general!.success!
              : Config.langFulText.general!.error!,
          content: body["message"],
          btnText: Config.langFulText.general!.okay!),
    );
  }
}
