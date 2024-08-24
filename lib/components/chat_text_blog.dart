import 'package:cached_network_image/cached_network_image.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTextBlog extends StatelessWidget {
  final bool userStatu;
  final String msgText, msgTime, msgImage;
  const ChatTextBlog(
      {super.key,
      required this.msgText,
      required this.msgTime,
      required this.userStatu,
      required this.msgImage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: userStatu ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width / 3 * 2,
        decoration: BoxDecoration(
          color: userStatu
              ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
              : ThemeColors.getColorTheme(Config.themType)["color3"],
          borderRadius: userStatu
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(12.8),
                  topLeft: Radius.circular(12.8),
                  bottomRight: Radius.circular(12.8),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(12.8),
                  topRight: Radius.circular(12.8),
                  bottomRight: Radius.circular(12.8),
                ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              userStatu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: (msgImage != "" && msgImage != "null") ? true : false,
              child: (msgImage != "" && msgImage != "null")
                  ? CachedNetworkImage(
                      imageUrl: msgImage,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const Text(""),
            ),
            Text(
              textAlign: TextAlign.left,
              msgText,
              style: GoogleFonts.firaSans(
                fontSize: 16,
                color: (userStatu)
                    ? ThemeColors.getColorTheme(Config.themType)["color1fix"]
                    : ThemeColors.getColorTheme(Config.themType)["color10"],
                height: 1.3,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 1.6,
            ),
            Text(
              msgTime,
              style: GoogleFonts.firaSans(
                fontSize: 12.8,
                color: (userStatu)
                    ? ThemeColors.getColorTheme(Config.themType)["color1fix"]!
                        .withOpacity(0.6)
                    : ThemeColors.getColorTheme(Config.themType)["color7"],
                height: 1.3,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
