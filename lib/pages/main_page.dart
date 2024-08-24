import 'dart:async';

import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/pages/chat_page.dart';
import 'package:tryt/pages/choose_page.dart';
import 'package:tryt/pages/home_page.dart';
import 'package:tryt/pages/myaccont_page.dart';
import 'package:tryt/pages/notification_page.dart';
import 'package:tryt/services/notificationhanler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ThemeController themeController = Get.put(ThemeController());
  CupertinoTabController tabController = CupertinoTabController();

  // List<int> _pageHistory = [0];
  final GlobalKey<NavigatorState> sayfa1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> sayfa2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> sayfa3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> sayfa4 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> sayfa5 = GlobalKey<NavigatorState>();

  // int activePage = 0;
  @override
  void initState() {
    super.initState();
    NotificationHandler().insertlistin(context);
    tabController = CupertinoTabController(initialIndex: 0);
    themeController.getMyuser();
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [sayfa1, sayfa2, sayfa3, sayfa4, sayfa5];
    List<Widget> sayfalar = [
      const HomePage(),
      const ChatPage(),
      const ChoosePage(),
      const NotificationPage(),
      const MyaccontPage(),
    ];
    return WillPopScope(
      onWillPop: () async {
        bool durum =
            !await listOfKeys[tabController.index].currentState!.maybePop();
        if (durum) {
          if (tabController.index > 0) {
            setState(() {
              tabController.index = 0;
            });
            return false;
          } else {
            bool status = await _showAlertDialog(context);
            return status;
          }
        }
        return durum;
      },
      child: CupertinoTabScaffold(
        controller: tabController,
        tabBar: CupertinoTabBar(
          height: 64,
          border: Border.all(color: Colors.transparent),
          backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: (tabController.index == 0)
                    ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
                    : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svgs/home.svg",
                  colorFilter: ColorFilter.mode(
                    (tabController.index == 0)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["color1fix"]!
                        : ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: (tabController.index == 1)
                    ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
                    : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svgs/chat.svg",
                  colorFilter: ColorFilter.mode(
                    (tabController.index == 1)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["color1fix"]!
                        : ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: (tabController.index == 2)
                    ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
                    : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svgs/add.svg",
                  colorFilter: ColorFilter.mode(
                    (tabController.index == 2)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["color1fix"]!
                        : ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: (tabController.index == 3)
                    ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
                    : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svgs/notification.svg",
                  colorFilter: ColorFilter.mode(
                    (tabController.index == 3)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["color1fix"]!
                        : ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: (tabController.index == 4)
                    ? ThemeColors.getColorTheme(Config.themType)["colorprimary"]
                    : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svgs/profile.svg",
                  colorFilter: ColorFilter.mode(
                    (tabController.index == 4)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["color1fix"]!
                        : ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              tabController.index = index;
            });
          },
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: listOfKeys[index],
            builder: (context) {
              return sayfalar[index];
            },
          );
        },
      ),
    );
  }

  Future<bool> _showAlertDialog(BuildContext context) {
    Completer<bool> completer = Completer<bool>();

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Dikkat'),
        content: const Text('Uygulamadan çıkmak istediğinizden emin misiniz?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(false);
            },
            child: Text(
              'Hayır',
              style: TextStyle(
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(true);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
    return completer.future;
  }
}
