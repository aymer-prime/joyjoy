import 'package:get/get.dart';
import 'package:tryt/components/profil_image_edit.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/pages/my_account_pages/myaccontedit_page.dart';
import 'package:tryt/pages/my_account_pages/notifications_page.dart';
import 'package:tryt/pages/my_account_pages/setting_page.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MyaccontPage extends StatefulWidget {
  const MyaccontPage({super.key});

  @override
  State<MyaccontPage> createState() => _MyaccontPageState();
}

class _MyaccontPageState extends State<MyaccontPage> {
  late final PageController pageController;
  void navigateToIndex(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutCirc,
    );
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MyAccountMain(
            navigateToIndex: navigateToIndex,
          ),
          MyacconteditPage(
            backToMain: () {
              navigateToIndex(0);
            },
          ),
          SettingPage(
            backToMain: () {
              navigateToIndex(0);
            },
          ),
          NotificationsPage(
            backToMain: () {
              navigateToIndex(0);
            },
          ),
        ],
      ),
    );
  }
}

class MyAccountMain extends StatelessWidget {
  final Function(int) navigateToIndex;
  const MyAccountMain({
    super.key,
    required this.navigateToIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      children: [
        const ProfilImageEdit(
          userNameStatus: true,
          paddingTop: 16,
        ),
        ListTile(
          onTap: () {
            navigateToIndex(1);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => const MyacconteditPage()));
          },
          leading: Icon(
            LineariconsFree.user_1,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
          title: Text(
            Config.langFulText.profile!.edit!.pageTitle!,
            style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w500,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
        ListTile(
          onTap: () {
            navigateToIndex(2);
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (conter) => const SettingPage()));
          },
          leading: Icon(
            Linecons.cog,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
          title: Text(
            Config.langFulText.settings!.pageTitle!,
            style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w500,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
        ListTile(
          onTap: () {
            navigateToIndex(3);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (contex) => const NotificationsPage()));
          },
          leading: Icon(
            FontAwesome.bell,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
          title: Text(
            Config.langFulText.notifications!.pageTitle!,
            style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w500,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
        ListTile(
          leading: Icon(
            FontAwesome.credit_card,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
          title: Text(
            Config.langFulText.purchases!.pageTitle!,
            style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w500,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
        ListTile(
          leading: Icon(
            FontAwesome5.headset,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
          title: Text(
            Config.langFulText.helpSupport!.pageTitle!,
            style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w500,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
        ListTile(
          onTap: () async {
            await PrefService().setString("email", "");
            await PrefService().setString("password", "");
            // ignore: use_build_context_synchronously
            Get.offAndToNamed('/');
          },
          leading: Icon(
            FontAwesome.logout,
            color: ThemeColors.getColorTheme(Config.themType)["colorprimary"],
          ),
          title: Text(
            Config.langFulText.general!.logout!,
            style: GoogleFonts.firaSans(
              color: ThemeColors.getColorTheme(Config.themType)["colorprimary"],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: Icon(Icons.chevron_right,
              color:
                  ThemeColors.getColorTheme(Config.themType)["colorprimary"]),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          textAlign: TextAlign.center,
          "Version 1.2.004021720900752 \n © 2024 Tüm hakları saklıdır.",
          style: GoogleFonts.firaSans(
            fontWeight: FontWeight.w400,
            fontSize: 12.8,
            height: 1.3,
            color: ThemeColors.getColorTheme(Config.themType)["color5"],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                "Kullanım Koşulları",
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  fontSize: 12.8,
                  height: 1.3,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            Text(
              ' - ',
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w400,
                fontSize: 12.8,
                height: 1.3,
                color: ThemeColors.getColorTheme(Config.themType)["color5"],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "K.V.K.K.",
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.8,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            Text(
              ' - ',
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w400,
                fontSize: 12.8,
                height: 1.3,
                color: ThemeColors.getColorTheme(Config.themType)["color5"],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Gizlilik Politikası",
                style: GoogleFonts.firaSans(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.8,
                  height: 1.3,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        )
      ],
    );
  }
}
