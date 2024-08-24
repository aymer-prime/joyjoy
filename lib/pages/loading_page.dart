import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/models/lang_string_model.dart';
import 'package:tryt/models/userinfo_model.dart';
import 'package:tryt/pages/activation_page.dart';
import 'package:tryt/pages/swiper_page.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatefulWidget {
  final String langText;
  const LoadingPage({super.key, required this.langText});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final ThemeController themeController = Get.put(ThemeController());
  @override
  void initState() {
    super.initState();
    getLangFulText(Config.lang);
    loginControl();
  }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  getLangFulText(String lang) async {
    var data = await getLangFulTextApi(lang);
    Config.langFulText = data;
  }

  loginControl() async {
    String email = await PrefService().getString("email") ?? "";
    String password = await PrefService().getString("password") ?? "";
    String dil = Config.lang;
    if (email == "" && password == "") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } else {
      var data = {
        "email_username": email,
        "password": password,
        "lang": dil,
      };
      var sonuc = await Httpservices().postMethod("login/index.php", data);
      var body = json.decode(sonuc);
      var deger = body["result"];
      if (body["success"]) {
        var data = Userinfomodel.fromJson(deger);
        setState(() {
          Config.userBilgi = data;
        });
        if (body["result"]["page"] == "activation") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ActivationPage(
                email: email,
                password: password,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else if (body["result"]["page"] == "info") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SwiperPage(
                email: email,
                password: password,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeColors.getColorTheme(Config.themType)["colorprimary"],
      body: Center(
        child: Image.asset(
          "assets/images/logo-white.png",
          width: MediaQuery.of(context).size.width / 3 * 2,
        ),
      ),
    );
  }
}
