import 'package:flutter/material.dart';

class ThemeColors {
  static Map<String, Color> getColorTheme(String themType) {
    return {
      "colordanger": const Color(0xffdf2f5a),
      "colorsuccess": const Color(0xff00a575),
      "color1fix": const Color(0xffffffff),
      "color3fix": const Color(0xffEDEFF6),
      "color10fix": const Color(0xff000000),
      "colorprimary": (themType == "light")
          ? const Color(0xffEA3458)
          : const Color(0xffbf274c),
      "color1": (themType == "light")
          ? const Color(0xffffffff)
          : const Color(0xff000000),
      "color2": (themType == "light")
          ? const Color(0xfff5f7fa)
          : const Color(0xff161718),
      "color3": (themType == "light")
          ? const Color(0xffEDEFF6)
          : const Color(0xff3a3b3e),
      "color4": (themType == "light")
          ? const Color(0xffdae2e6)
          : const Color(0xff4b4f55),
      "color5": (themType == "light")
          ? const Color(0xffb1babf)
          : const Color(0xff555c60),
      "color6": (themType == "light")
          ? const Color(0xff828e95)
          : const Color(0xff757f85),
      "color7": (themType == "light")
          ? const Color(0xff4e5860)
          : const Color(0xff95a0a9),
      "color10": (themType == "light")
          ? const Color(0xff000000)
          : const Color(0xffffffff),
      "colorborder1": (themType == "light")
          ? const Color(0xffd6dbe2)
          : const Color(0xff222325),
      "color1opacity2": (themType == "light")
          ? const Color.fromARGB(51, 255, 255, 255)
          : const Color.fromARGB(51, 0, 0, 0),
      "color1opacity7": (themType == "light")
          ? const Color.fromARGB(178, 255, 255, 255)
          : const Color.fromARGB(178, 0, 0, 0),
      "color1opacity9": (themType == "light")
          ? const Color.fromARGB(299, 255, 255, 255)
          : const Color.fromARGB(299, 0, 0, 0),
      "color10opacity7": const Color.fromARGB(178, 0, 0, 0),
    };
  }
}
