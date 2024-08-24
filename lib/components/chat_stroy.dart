import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_dots.dart';

class ChatStroy extends StatefulWidget {
  final String userImage, userTitle;
  final VoidCallback onpress;
  const ChatStroy(
      {super.key,
      required this.userImage,
      required this.userTitle,
      required this.onpress});

  @override
  State<ChatStroy> createState() => _ChatStroyState();
}

class _ChatStroyState extends State<ChatStroy> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: ThemeColors.getColorTheme(Config.themType)["color4"],
            radius: 33.6,
            child: Container(
              width: 67.2,
              height: 67.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33.6),
              ),
              child: ClipOval(
                child: Image.network(
                  widget.userImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                          child: AnimatedDots(
                            activeColor: ThemeColors.getColorTheme(Config.themType)["color5"]!,
                            inactiveColor: ThemeColors.getColorTheme(Config.themType)["color7"]!,
                          ));
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
            height: 6.4,
          ),
          Text(
            widget.userTitle,
            style: GoogleFonts.firaSans(
              fontSize: 14.4,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          )
        ],
      ),
    );
  }
}
