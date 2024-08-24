import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTextButton extends StatelessWidget {
  final String counter;
  final VoidCallback onpress;
  final Widget btnIcon;
  const IconTextButton(
      {super.key,
      required this.counter,
      required this.onpress,
      required this.btnIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        child: Row(
          children: [
            btnIcon,
            const SizedBox(
              width: 5,
            ),
            Text(
              counter,
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w400,
                color: ThemeColors.getColorTheme(Config.themType)["color7"],
                height: 1.3,
                fontSize: 14.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
