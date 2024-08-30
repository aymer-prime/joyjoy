import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List statuslar = [true, false, false, true, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              centerTitle: true,
              surfaceTintColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              backgroundColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              leading: const AppBarBack(
                leftPadding: 0,
              ),
              title: Text(
                Config.langFulText.notifications!.pageTitle!,
                style: GoogleFonts.mukta(
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                  fontSize: 23,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Yeni sohbet mesajı bildirimleri",
                    style: GoogleFonts.firaSans(
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.3),
                  ),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      // This bool value toggles the switch.
                      value: statuslar[index],
                      activeColor: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                      onChanged: (bool? value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          statuslar[index] = value;
                        });
                      },
                    ),
                  ),
                );
              },
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
