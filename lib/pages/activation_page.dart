import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/userinfo_model.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivationPage extends StatefulWidget {
  final String email, password;
  const ActivationPage(
      {super.key, required this.email, required this.password});

  @override
  State<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Icon(
              FontAwesome5.hourglass_half,
              size: 64,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              textAlign: TextAlign.center,
              Config.langFulText.activation!.title!,
              style: GoogleFonts.mukta(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                height: 1.1,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              textAlign: TextAlign.center,
              Config.langFulText.activation!.description!
                  .replaceAll('[email]', widget.email),
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w400,
                fontSize: 14.4,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                height: 1.3,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ButtonText(
              btnText: Config.langFulText.activation!.button!,
              bgColor: ThemeColors.getColorTheme(Config.themType)["color10"]!,
              textColor: ThemeColors.getColorTheme(Config.themType)["color1"]!,
              onpress: () async {
                Config.genelModal(context, const LoadingModal());
                var data = {"email": widget.email, "lang": "tr"};
                var sonuc = await Httpservices()
                    .postMethod("login/activation-resend.php", data);
                var body = json.decode(sonuc);
                Navigator.pop(context);
                Config.genelModal(
                  context,
                  AlertBox(
                    alertIcon: (body["success"] == true)
                        ? FontAwesome5.check
                        : Icons.priority_high,
                    alertColor: (body["success"] == true)
                        ? const Color(0xff2ecc71)
                        : ThemeColors.getColorTheme(
                            Config.themType)["colordanger"]!,
                    title: (body["success"] == true)
                        ? Config.langFulText.general!.success!
                        : Config.langFulText.general!.error!,
                    content: body["message"],
                    btnText: Config.langFulText.general!.okay!,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              textAlign: TextAlign.center,
              Config.langFulText.activation!.help!,
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w400,
                fontSize: 12.8,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                height: 1.3,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextButton(
              onPressed: () async {
                getLogin();
              },
              child: Text(
                Config.langFulText.activation!.refresh!,
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.4,
                  height: 1.3,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLogin() async {
    Config.genelModal(context, const LoadingModal());
    var data = {
      "email_username": widget.email,
      "password": widget.password,
      "lang": Config.lang,
    };
    var sonuc = await Httpservices().postMethod("login/index.php", data);
    var body = json.decode(sonuc);
    var deger = body["result"];
    if (body["success"]) {
      Navigator.pop(context);
      if (body["result"]["page"] != "activation") {
        var data = Userinfomodel.fromJson(deger);
        setState(() {
          Config.userBilgi = data;
        });

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
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
            btnText: Config.langFulText.general!.okay!),
      );
    }
  }
}
