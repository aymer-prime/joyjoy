import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseButton extends StatelessWidget {
  final String title, imageUrl;
  final VoidCallback onpress;
  final FontWeight fontWeights;
  final double fontsize, borderradius;
  const ChooseButton(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onpress,
      required this.fontsize,
      required this.borderradius,
      required this.fontWeights});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderradius),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 64, bottom: 16, left: 16, right: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderradius),
                    bottomRight: Radius.circular(borderradius)),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(1, 0, 0, 0),
                    Color.fromARGB(100, 0, 0, 0),
                  ],
                ),
              ),
              child: Text(
                title,
                style: GoogleFonts.firaSans(
                  fontSize: fontsize,
                  height: 1.3,
                  color:
                      ThemeColors.getColorTheme(Config.themType)["color1fix"],
                  fontWeight: fontWeights,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
