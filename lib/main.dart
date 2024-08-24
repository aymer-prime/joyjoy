import 'dart:io';

import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/pages/chat_detail_page.dart';
import 'package:tryt/pages/intro_page.dart';
import 'package:tryt/pages/loading_page.dart';
import 'package:tryt/pages/login_page.dart';
import 'package:tryt/pages/main_page.dart';
import 'package:tryt/pages/model_detay_page.dart';
import 'package:tryt/pages/singup_page.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: Config().settings(),
  );
  // await NotificationService.initializeNotification();
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());
  String sysTheme = "system";
  String lngText = "en";
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  loadPage() async {
    sysTheme = await PrefService().getString("sysTeme") ?? "light";
    lngText = await PrefService().getString("systhemLang") ?? "";
    if (lngText == "") {
      Locale? deviceLocale = Get.deviceLocale;
      lngText = deviceLocale.toString().split("_")[0].toString();
      await PrefService().setString("systhemLang", lngText);
      await PrefService().setString("sysTeme", sysTheme);
    }
    setState(() {
      Config.themType = sysTheme;
      themeController.themeLang.value = lngText.toString();
      Config.lang = lngText.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.firaSans().fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          focusColor: ThemeColors.getColorTheme(sysTheme)["color2"],
          fillColor: ThemeColors.getColorTheme(sysTheme)["color2"],
          filled: true,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 16,
            color: ThemeColors.getColorTheme(sysTheme)["color10"],
          ),
          hintStyle: GoogleFonts.firaSans(
            fontSize: 16,
            color: ThemeColors.getColorTheme(sysTheme)["color5"],
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.8),
              borderSide: BorderSide(
                  color: ThemeColors.getColorTheme(sysTheme)["colorborder1"]!,
                  width: 1)),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 19.2, vertical: 19.2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.8),
            borderSide: BorderSide(
                color: ThemeColors.getColorTheme(sysTheme)["colorborder1"]!,
                width: 1),
          ),
        ),
        scaffoldBackgroundColor: ThemeColors.getColorTheme(sysTheme)["color1"],
        bottomAppBarTheme: BottomAppBarTheme(
          color: ThemeColors.getColorTheme(sysTheme)["color1"],
        ),
        colorSchemeSeed: ThemeColors.getColorTheme(sysTheme)["color1"],
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => (Config.langFulText.home != null)
            ? Directionality(
                textDirection: (themeController.themeLang == "ar")
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: const IntroPage())
            : Directionality(
                textDirection: (themeController.themeLang == "ar")
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: LoadingPage(
                  langText: lngText,
                ),
              ),
        "/login": (context) => Directionality(
            textDirection: (themeController.themeLang == "ar")
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: const LoginPage()),
        "/loginpage": (context) => Directionality(
            textDirection:
                (lngText == "ar") ? TextDirection.rtl : TextDirection.ltr,
            child: const SingupPage()),
        "/home": (context) => Directionality(
              textDirection: (themeController.themeLang == "ar")
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: const MainPage(),
            ),
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> veri = settings.name!.split("/");
        if (veri[1] == "chatDetail" && veri[2] != "") {
          return MaterialPageRoute(
              builder: (context) => ChatDetailPage(
                    chatId: veri[2].toString(),
                  ));
        } else if (veri[1] == "model-detail") {
          return MaterialPageRoute(
              builder: (context) => Directionality(
                  textDirection: (themeController.themeLang == "ar")
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: const ModelDetayPage()));
        }

        return MaterialPageRoute(
            builder: (context) => Directionality(
                textDirection: (themeController.themeLang == "ar")
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: const IntroPage()));
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (context) => Directionality(
                textDirection: (themeController.themeLang == "ar")
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: const IntroPage()));
      },
    );
  }
}
