import 'dart:convert';
import 'dart:io';

import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/lang_string_model.dart';
import 'package:tryt/models/userinfo_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Config {
  static String siteUrl = "https://joyjoy.ai/api/";
  static String basetoken = "";
  static Langstringmodel langFulText = Langstringmodel();
  static String lang = "tr";
  static Userinfomodel userBilgi = Userinfomodel();
  static String themType = "light";

  static void showBottomMenu(BuildContext context, Widget contents) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return contents;
      },
    );
  }

  static void genelModal(BuildContext context, Widget contents) async {
    showDialog(
      barrierColor: ThemeColors.getColorTheme(Config.themType)["color10"]!
          .withOpacity(0.1),
      context: context,
      builder: (BuildContext context) {
        return contents;
      },
    );
  }

  static void modalCenter(BuildContext context, Widget contents) async {
    return showDialog(
      barrierColor: ThemeColors.getColorTheme(Config.themType)["color10"]!
          .withOpacity(0.1),
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          backgroundColor: Colors.transparent,
          content: contents,
        );
      },
    );
  }

  String generateHash(
      String email, String fullname, String date, String userid) {
    String data = email + fullname + date + userid;
    List<int> bytes = utf8.encode(data);
    Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  settings() {
    if (Platform.isAndroid) {
      return const FirebaseOptions(
        appId: '1:960728487581:android:3e72ef3975dbda48d3e674',
        apiKey: 'AIzaSyA98R-dxxsoNAaUYD67CA2-iUphEkP2Y54',
        projectId: 'joyjoy-bd495',
        messagingSenderId: '960728487581',
      );
    } else {
      return const FirebaseOptions(
        appId: '1:960728487581:ios:b309a6dd27688463d3e674',
        apiKey: 'AIzaSyBubgCi2PBD8O6F1jMH50ifImz5gGhL8jk',
        projectId: 'joyjoy-bd495',
        messagingSenderId: '29752322975',
      );
    }
  }

  List<TextSpan> getTextSpansFromHtml(String html) {
    final RegExp exp = RegExp(r'\[a href="([^"]+)"\](.*?)\[/a\]');
    List<TextSpan> spans = [];
    int lastMatchEnd = 0;
    for (final Match match in exp.allMatches(html)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          style: GoogleFonts.firaSans(
            color: ThemeColors.getColorTheme(Config.themType)["color5"],
            fontSize: 12.8,
            fontWeight: FontWeight.w400,
          ),
          text: html.substring(lastMatchEnd, match.start),
        ));
      }
      final String url = match.group(1)!;
      final String linkText = match.group(2)!;

      spans.add(TextSpan(
        text: linkText,
        style: GoogleFonts.firaSans(
          color: ThemeColors.getColorTheme(Config.themType)["color10"],
          fontSize: 12.8,
          fontWeight: FontWeight.w400,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            _launchURL(url);
          },
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < html.length) {
      spans.add(TextSpan(text: html.substring(lastMatchEnd)));
    }

    return spans;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
