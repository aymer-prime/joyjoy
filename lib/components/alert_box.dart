import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertBox extends StatelessWidget {
  final IconData alertIcon;
  final String title, content, btnText;
  final Color alertColor;
  const AlertBox(
      {super.key,
      required this.alertIcon,
      required this.title,
      required this.content,
      required this.btnText,
      required this.alertColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          child: Container(
            width: MediaQuery.of(context).size.width - 64,
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: ThemeColors.getColorTheme(Config.themType)["color1"],
              borderRadius: BorderRadius.circular(12.8),
              border: Border(
                top: BorderSide(
                  width: 7,
                  color: alertColor,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  alertIcon,
                  size: 69,
                  color: alertColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.firaSans(
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  textAlign: TextAlign.center,
                  content,
                  style: GoogleFonts.firaSans(
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.8),
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color3"]),
                    child: Text(
                      btnText,
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
