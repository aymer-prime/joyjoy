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
      padding: EdgeInsets.only(left: leftPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          FontAwesome5.chevron_left,
          color: ThemeColors.getColorTheme(Config.themType)["color10"],
          size: 19,
        ),
      ),
    );
  }
}
