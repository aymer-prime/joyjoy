import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_dots.dart';

class StoryAvatar extends StatelessWidget {
  final String userName, userImageUrl;
  final VoidCallback onpress;
  const StoryAvatar(
      {super.key,
      required this.userName,
      required this.userImageUrl,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 77.2,
            height: 77.2,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 238, 88, 63),
                  Color.fromARGB(255, 217, 45, 119),
                  Color.fromARGB(255, 189, 51, 129),
                ],
              ),
              borderRadius: BorderRadius.circular(38),
            ),
            child: CircleAvatar(
              backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
              radius: 33.6,
              child: Container(
                width: 67.2,
                height: 67.2,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(68),
                ),
                child: ClipOval(
                  child: Image.network(
                    userImageUrl,
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
          ),
          const SizedBox(
            height: 3.2,
          ),
          Text(
            userName,
            style: GoogleFonts.firaSans(
              fontSize: 14.4,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              height: 1.2,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 1.6,
          ),
        ],
      ),
    );
  }
}
