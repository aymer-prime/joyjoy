import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        centerTitle: true,
        leading: const AppBarBack(),
        title: Text(
          Config.langFulText.deleteAccount!.pageTitle!,
          style: GoogleFonts.mukta(
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
            fontWeight: FontWeight.w800,
            fontSize: 23,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text(
            Config.langFulText.deleteAccount!.description!,
            textAlign: TextAlign.center,
            style: GoogleFonts.firaSans(
              color: ThemeColors.getColorTheme(Config.themType)["color7"],
              fontWeight: FontWeight.w400,
              height: 1.25,
              fontSize: 14.4,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            Config.langFulText.deleteAccount!.approval!,
            textAlign: TextAlign.center,
            style: GoogleFonts.firaSans(
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ButtonText(
            onpress: () async {},
            btnText: Config.langFulText.deleteAccount!.buttons!.success!,
            bgColor:
                ThemeColors.getColorTheme(Config.themType)["colorprimary"]!,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
