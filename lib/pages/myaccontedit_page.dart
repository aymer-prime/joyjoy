import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/custom_outlin_boreder.dart';
import 'package:tryt/components/profil_image_edit.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/pages/delete_account_page.dart';
import 'package:tryt/pages/password_edit_page.dart';
import 'package:tryt/pages/user_name_edit_page.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyacconteditPage extends StatefulWidget {
  const MyacconteditPage({super.key});

  @override
  State<MyacconteditPage> createState() => _MyacconteditPageState();
}

class _MyacconteditPageState extends State<MyacconteditPage> {
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController ad = TextEditingController();
  final TextEditingController soyad = TextEditingController();
  late String email = "";
  String kullanici = "";
  String? gun, ay, yil, cinsiyet;
  @override
  void initState() {
    super.initState();
    ad.text = themeController.userInfo.first.name!;
    soyad.text = themeController.userInfo.first.surname!;
    email = themeController.userInfo.first.email!;
    kullanici = themeController.userInfo.first.username!;
    gun = themeController.userInfo.first.birthday!.day;
    ay = themeController.userInfo.first.birthday!.month;
    yil = themeController.userInfo.first.birthday!.year;
    cinsiyet = themeController.userInfo.first.gender;
  }

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
              leading: const AppBarBack(),
              title: Text(
                Config.langFulText.profile!.edit!.pageTitle!,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            const ProfilImageEdit(
              userNameStatus: false,
              paddingTop: 8,
            ),
            Text(
              Config.langFulText.general!.email!,
              style: GoogleFonts.firaSans(
                fontSize: 12.8,
                color: ThemeColors.getColorTheme(Config.themType)["color5"]!,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              email,
              style: GoogleFonts.firaSans(
                fontSize: 16,
                height: 1.25,
                color: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.getColorTheme(Config.themType)["color2"],
                border: Border.all(
                  width: 1,
                  color: ThemeColors.getColorTheme(
                      Config.themType)["colorborder1"]!,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: accountCredintialField(
                title: Config.langFulText.general!.username!,
                subtitle: themeController.userInfo.first.username!,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserNameEditPage()));
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.getColorTheme(Config.themType)["color2"],
                border: Border.all(
                  width: 1,
                  color: ThemeColors.getColorTheme(
                      Config.themType)["colorborder1"]!,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: accountCredintialField(
                title: Config.langFulText.general!.password!,
                subtitle: "******",
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PasswordEditPage()));
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Config.langFulText.general!.general!,
              style: GoogleFonts.firaSans(
                fontSize: 16,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              child: TextFormField(
                controller: ad,
                style: GoogleFonts.firaSans(
                  fontSize: 16,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                ),
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(
                    color: ThemeColors.getColorTheme(Config.themType)["color5"],
                  ),
                  labelText: Config.langFulText.general!.name!,
                  labelStyle: GoogleFonts.firaSans(
                    fontSize: 12.8,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"]!,
                    fontWeight: FontWeight.w400,
                  ),
                  border: CustomOutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.getColorTheme(
                          Config.themType)["color10"]!,
                    ),
                  ),
                  enabledBorder: CustomOutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color4"]!,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: soyad,
              style: GoogleFonts.firaSans(
                fontSize: 16,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(
                  color: ThemeColors.getColorTheme(Config.themType)["color5"],
                ),
                labelText: Config.langFulText.general!.surname!,
                labelStyle: GoogleFonts.firaSans(
                  fontSize: 12.8,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                  fontWeight: FontWeight.w400,
                ),
                border: CustomOutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"]!,
                  ),
                ),
                enabledBorder: CustomOutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color4"]!,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeColors.getColorTheme(Config.themType)["color2"],
                    border: Border.all(
                      width: 1,
                      color: ThemeColors.getColorTheme(
                          Config.themType)["colorborder1"]!,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Config.langFulText.general!.day!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color5"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(
                                    Config.langFulText.general!.choose!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                    ),
                                  ),
                                  items: [
                                    for (int i = 1; i <= 31; i++)
                                      DropdownMenuItem<String>(
                                        value: i.toString().padLeft(2, '0'),
                                        child: Text(
                                            i.toString().padLeft(2, '0')),
                                      ),
                                  ],
                                  value: gun,
                                  onChanged: (String? yeniSecim) {
                                    setState(() {
                                      gun = yeniSecim!;
                                    });
                                  },
                                  style: TextStyle(
                                    color: ThemeColors.getColorTheme(
                                        Config.themType)["color10"],
                                    fontSize: 16,
                                  ),
                                  iconEnabledColor: ThemeColors.getColorTheme(
                                      Config.themType)["color10"],
                                  iconDisabledColor:
                                      ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                  dropdownColor: ThemeColors.getColorTheme(
                                      Config.themType)["color2"],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 0.0,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color4"],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Config.langFulText.general!.month!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color5"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(
                                    Config.langFulText.general!.choose!,
                                    style: TextStyle(
                                      color: ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                    ),
                                  ),
                                  items: [
                                    for (int i = 1;
                                        i <=
                                            Config.langFulText.general!
                                                .months!.length;
                                        i++)
                                      DropdownMenuItem<String>(
                                        value: i.toString().padLeft(2, '0'),
                                        child: Text(Config.langFulText
                                            .general!.months![(i - 1)].name!),
                                      ),
                                  ],
                                  value: ay,
                                  onChanged: (String? yeniSecim) {
                                    setState(() {
                                      ay = yeniSecim!;
                                    });
                                  },
                                  style: TextStyle(
                                    color: ThemeColors.getColorTheme(
                                        Config.themType)["color10"],
                                    fontSize: 16,
                                  ),
                                  iconEnabledColor: ThemeColors.getColorTheme(
                                      Config.themType)["color10"],
                                  iconDisabledColor:
                                      ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                  dropdownColor: ThemeColors.getColorTheme(
                                      Config.themType)["color2"],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 0.0,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color4"],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Config.langFulText.general!.year!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color5"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  padding: EdgeInsets.zero,
                                  hint: Text(
                                    Config.langFulText.general!.choose!,
                                    style: TextStyle(
                                      color: ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                    ),
                                  ),
                                  items: [
                                    for (int i = DateTime.now().year - 18;
                                        i > DateTime.now().year - 90;
                                        i--)
                                      DropdownMenuItem<String>(
                                        value: i.toString(),
                                        child: Text(i.toString()),
                                      ),
                                  ],
                                  value: yil,
                                  onChanged: (String? yeniSecim) {
                                    setState(() {
                                      yil = yeniSecim!;
                                    });
                                  },
                                  style: TextStyle(
                                    color: ThemeColors.getColorTheme(
                                        Config.themType)["color10"],
                                  ),
                                  iconEnabledColor: ThemeColors.getColorTheme(
                                      Config.themType)["color10"],
                                  iconDisabledColor:
                                      ThemeColors.getColorTheme(
                                          Config.themType)["color10"],
                                  dropdownColor: ThemeColors.getColorTheme(
                                      Config.themType)["color2"],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     // Expanded(
                //     //   flex: 1,
                //     //   child: Container(
                //     //     transform: Matrix4.translationValues(10.0, -68.0, 10.0),
                //     //     child: Text(
                //     //       Config.langFulText.general!.day!,
                //     //       style: GoogleFonts.firaSans(
                //     //         fontWeight: FontWeight.w400,
                //     //         color: ThemeColors.getColorTheme(
                //     //             Config.themType)["color10"]!,
                //     //         fontSize: 12.8,
                //     //       ),
                //     //     ),
                //     //   ),
                //     // ),
                //     Expanded(
                //       flex: 1,
                //       child: Container(
                //         transform: Matrix4.translationValues(10.0, -68.0, 10.0),
                //         child: Text(
                //           Config.langFulText.general!.month!,
                //           style: GoogleFonts.firaSans(
                //             fontWeight: FontWeight.w400,
                //             color: ThemeColors.getColorTheme(
                //                 Config.themType)["color10"]!,
                //             fontSize: 12.8,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Config.langFulText.general!.gender!,
              style: GoogleFonts.firaSans(
                fontSize: 16,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  cinsiyet = "1";
                });
              },
              tileColor: ThemeColors.getColorTheme(Config.themType)["color2"],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: ThemeColors.getColorTheme(
                        Config.themType)["colorborder1"]!,
                    width: 1),
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                Config.langFulText.general!.male!,
                style: GoogleFonts.firaSans(
                  fontSize: 17.6,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                ),
              ),
              trailing: Radio(
                value: "1",
                activeColor:
                    ThemeColors.getColorTheme(Config.themType)["colorprimary"],
                groupValue: cinsiyet,
                onChanged: (value) {
                  setState(() {
                    cinsiyet = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  cinsiyet = "2";
                });
              },
              tileColor: ThemeColors.getColorTheme(Config.themType)["color2"],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: ThemeColors.getColorTheme(
                        Config.themType)["colorborder1"]!,
                    width: 1),
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                Config.langFulText.general!.female!,
                style: GoogleFonts.firaSans(
                  fontSize: 17.6,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                ),
              ),
              trailing: Radio(
                value: "2",
                activeColor:
                    ThemeColors.getColorTheme(Config.themType)["colorprimary"],
                groupValue: cinsiyet,
                onChanged: (value) {
                  setState(() {
                    cinsiyet = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  cinsiyet = "3";
                });
              },
              tileColor: ThemeColors.getColorTheme(Config.themType)["color2"],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: ThemeColors.getColorTheme(
                        Config.themType)["colorborder1"]!,
                    width: 1),
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                Config.langFulText.info!.dontWant!,
                style: GoogleFonts.firaSans(
                  fontSize: 17.6,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                ),
              ),
              trailing: Radio(
                value: "3",
                groupValue: cinsiyet,
                activeColor:
                    ThemeColors.getColorTheme(Config.themType)["colorprimary"],
                onChanged: (value) {
                  setState(() {
                    cinsiyet = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ButtonText(
              onpress: () async {
                kaydet();
              },
              btnText: Config.langFulText.general!.save!,
              bgColor:
                  ThemeColors.getColorTheme(Config.themType)["colorprimary"]!,
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonText(
              onpress: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contex) => const DeleteAccountPage()));
              },
              btnText: "Hesap Sil",
              bgColor: Colors.transparent,
              textColor:
                  ThemeColors.getColorTheme(Config.themType)["colorprimary"]!,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  kaydet() async {
    var data = {
      "user_id": Config.userBilgi.userId,
      "token": Config.userBilgi.token,
      "lang": Config.lang,
      "name": ad.text,
      "surname": soyad.text,
      "day": gun,
      "month": ay,
      "year": yil,
      "gender": cinsiyet,
    };
    var sonuc = await Httpservices().postMethod("profile/edit.php", data);
    var body = json.decode(sonuc);
    if (body["success"]) {
      themeController.getMyuser();
    }
    Config.genelModal(
      // ignore: use_build_context_synchronously
      context,
      AlertBox(
          alertIcon: (body["success"]) ? Icons.check : Icons.priority_high,
          alertColor: (body["success"])
              ? ThemeColors.getColorTheme(Config.themType)["colorsuccess"]!
              : ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
          title: (body["success"])
              ? Config.langFulText.general!.success!
              : Config.langFulText.general!.error!,
          content: body["message"],
          btnText: Config.langFulText.general!.okay!),
    );
  }
}

class accountCredintialField extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPress;
  const accountCredintialField({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.getColorTheme(Config.themType)["color5"]!,
                  fontSize: 12.8,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: GoogleFonts.firaSans(
                  color: ThemeColors.getColorTheme(Config.themType)["color7"]!,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onPress,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ThemeColors.getColorTheme(Config.themType)["color3"]!,
              ),
              child: Text(
                Config.langFulText.general!.edit!,
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"]!,
                  fontSize: 12.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
