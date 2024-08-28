import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class AppBarBack extends StatelessWidget {
  final double leftPadding;
  const AppBarBack({super.key, this.leftPadding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.8),
            border: Border.all(
                width: 1,
                color: ThemeColors.getColorTheme(
                    Config.themType)["colorborder1"]!),
          ),
          child: Icon(
            FontAwesome5.chevron_left,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
            size: 19,
          ),
        ),
      ),
    );
  }
}
