import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class UserlisteCard extends StatelessWidget {
  final String title, imageUrl, yas, subTitle;
  final VoidCallback onpress;
  const UserlisteCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onpress,
      required this.yas,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.8),
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
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 16, right: 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.8),
                    bottomRight: Radius.circular(12.8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(1, 0, 0, 0),
                    Color.fromARGB(150, 0, 0, 0),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "$title,",
                      style: GoogleFonts.firaSans(
                        fontSize: 28.8,
                        height: 1.3,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color1fix"],
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                          text: yas,
                          style: GoogleFonts.firaSans(
                            fontSize: 28.8,
                            height: 1.3,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color1fix"],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3.2,
                  ),
                  Text(
                    "Sevigli Adayı",
                    style: GoogleFonts.firaSans(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.getColorTheme(
                          Config.themType)["color3fix"],
                      fontSize: 17.6,
                    ),
                  ),
                  const SizedBox(
                    height: 4.8,
                  ),
                  Text(
                    subTitle,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w300,
                      color: ThemeColors.getColorTheme(
                          Config.themType)["color3fix"],
                      fontSize: 14.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: CircleAvatar(
              radius: 17.6,
              backgroundColor:
                  ThemeColors.getColorTheme(Config.themType)["color1opacity2"],
              child: Padding(
                padding: const EdgeInsets.only(top: 2.2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesome.heart_empty,
                      color: ThemeColors.getColorTheme(
                          Config.themType)["color1fix"],
                      size: 16,
                    ),
                    Text(
                      "105",
                      style: GoogleFonts.mukta(
                        fontSize: 11.2,
                        height: 1,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color1fix"],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
