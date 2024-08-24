import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNameEditPage extends StatefulWidget {
  const UserNameEditPage({super.key});

  @override
  State<UserNameEditPage> createState() => _UserNameEditPageState();
}

class _UserNameEditPageState extends State<UserNameEditPage> {
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController ad = TextEditingController();
  @override
  void initState() {
    super.initState();
    ad.text = themeController.userInfo.first.username!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor:
              ThemeColors.getColorTheme(Config.themType)["color1"],
          backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
          centerTitle: true,
          title: Text(
            Config.langFulText.profile!.editUsername!.pageTitle!,
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
            controller: ad,
            style: GoogleFonts.firaSans(
              fontSize: 16,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
            decoration: InputDecoration(
              labelText: Config.langFulText.general!.username!,
              labelStyle: GoogleFonts.firaSans(
                fontSize: 12.8,
                color: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                ),
              ),
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
      "username": ad.text,
    };
    var sonuc =
        await Httpservices().postMethod("profile/edit-username.php", data);
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
