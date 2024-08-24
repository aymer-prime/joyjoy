import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_dots.dart';

class Chatlist extends StatelessWidget {
  final VoidCallback onpress, onlongPress;
  final String userName, subcategory, mesajtext, sendate, userImage;
  const Chatlist(
      {super.key,
      required this.onpress,
      required this.onlongPress,
      required this.userName,
      required this.subcategory,
      required this.mesajtext,
      required this.sendate,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onpress,
        onLongPress: onlongPress,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 33.6,
              backgroundColor: ThemeColors.getColorTheme(Config.themType)["color4"],
              child: Container(
                width: 67.2,
                height: 67.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(67.2),
                ),
                child: ClipOval(
                  child: Image.network(
                    userImage,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: AnimatedDots(
                            activeColor: ThemeColors.getColorTheme(Config.themType)["color5"]!,
                            inactiveColor: ThemeColors.getColorTheme(Config.themType)["color7"]!,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12.8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.firaSans(
                          fontSize: 16,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const Expanded(
                        child: Text(""),
                      ),
                      Text(
                        sendate,
                        style: GoogleFonts.firaSans(
                          fontSize: 12.8,
                          height: 1.3,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color6"],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1.6,
                  ),
                  Text(
                    subcategory,
                    style: GoogleFonts.firaSans(
                      fontSize: 11.2,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color7"],
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    style: GoogleFonts.firaSans(
                      fontSize: 16,
                      height: 1.3,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color6"],
                    ),
                    overflow: TextOverflow.ellipsis,
                    mesajtext,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
