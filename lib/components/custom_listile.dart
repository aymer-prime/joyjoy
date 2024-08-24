import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListile extends StatelessWidget {
  final String userName, userImg, notificationText, notificationDate;
  const CustomListile(
      {super.key,
      required this.userName,
      required this.userImg,
      required this.notificationText,
      required this.notificationDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                ThemeColors.getColorTheme(Config.themType)["color10"],
            backgroundImage: NetworkImage(userImg),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$userName ",
                style: GoogleFonts.mukta(
                  fontSize: 16,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: notificationText,
                    style: GoogleFonts.firaSans(
                      fontSize: 14.4,
                      fontWeight: FontWeight.w400,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                  ),
                  TextSpan(
                    text: " $notificationDate",
                    style: GoogleFonts.firaSans(
                      fontSize: 12.8,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color6"],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.2),
            decoration: BoxDecoration(
              color: ThemeColors.getColorTheme(Config.themType)["color3"],
              borderRadius: BorderRadius.circular(4.8),
            ),
            child: Text(
              Config.langFulText.general!.detail!,
              style: GoogleFonts.firaSans(
                fontSize: 12.8,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        ],
      ),
    );
  }
}
