import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SwiperPage extends StatefulWidget {
  final String email, password;
  const SwiperPage({super.key, required this.email, required this.password});

  @override
  State<SwiperPage> createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  final PageController _pageController = PageController();
  String? gun, ay, yil, isim, soyisim;
  String? cinsiyet;
  int active = 0;
  @override
  void initState() {
    super.initState();
    isim = "";
    soyisim = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Visibility(
          visible: (active == 0) ? false : true,
          child: IconButton(
            onPressed: () {
              if (active == 0) {
                Navigator.pop(context);
              } else if (active == 1) {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  active = 0;
                });
              } else {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  active = 1;
                });
              }
            },
            icon: Icon(
              FontAwesome.angle_left,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          ),
        ),
        title: Image.asset(
          "assets/images/logo-red.png",
          width: 150,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 32,
                  ),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Config.langFulText.info!.step1Title!,
                          style: GoogleFonts.mukta(
                            fontSize: 28.8,
                            letterSpacing: -0.05,
                            height: 1.1,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          style: GoogleFonts.firaSans(
                            fontSize: 16,
                            color: ThemeColors.getColorTheme(Config.themType)[
                                "color10"], // Set entered text color to red
                          ),
                          onTap: () {
                            setState(() {
                              isim = "";
                            });
                          },
                          onChanged: (val) {
                            setState(() {
                              isim = val;
                            });
                          },
                          initialValue: isim,
                          decoration: InputDecoration(
                            labelText: Config.langFulText.general!.name!,
                            labelStyle: TextStyle(
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["color10"]!,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style: GoogleFonts.firaSans(
                            fontSize: 16,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                          ),
                          initialValue: soyisim,
                          onTap: () {
                            setState(() {
                              soyisim = "";
                            });
                          },
                          onChanged: (val) {
                            setState(() {
                              soyisim = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: Config.langFulText.general!.surname!,
                            labelStyle: TextStyle(
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["color10"]!,
                              fontSize: 19,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeColors.getColorTheme(
                                        Config.themType)[
                                    "colorborder1"]!, // Border rengini beyaz yapar
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ButtonText(
                            btnText: Config.langFulText.general!.next!,
                            bgColor: ThemeColors.getColorTheme(
                                Config.themType)["colorprimary"]!,
                            textColor: ThemeColors.getColorTheme(
                                Config.themType)["color1fix"]!,
                            onpress: () async {
                              if (isim == "") {
                                Config.genelModal(
                                  context,
                                  AlertBox(
                                    alertIcon: Icons.priority_high,
                                    alertColor: ThemeColors.getColorTheme(
                                        Config.themType)["colordanger"]!,
                                    title: Config.langFulText.general!.error!,
                                    content: Config
                                        .langFulText.info!.errorMessage!.name!,
                                    btnText: Config.langFulText.general!.okay!,
                                  ),
                                );
                              } else if (soyisim == "") {
                                Config.genelModal(
                                  context,
                                  AlertBox(
                                    alertIcon: Icons.priority_high,
                                    alertColor: ThemeColors.getColorTheme(
                                        Config.themType)["colordanger"]!,
                                    title: Config.langFulText.general!.error!,
                                    content: Config.langFulText.info!
                                        .errorMessage!.surname!,
                                    btnText: Config.langFulText.general!.okay!,
                                  ),
                                );
                              } else {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                                setState(() {
                                  active = 1;
                                });
                              }
                            }),
                        const Expanded(child: Text("")),
                        Text(
                          style: GoogleFonts.firaSans(
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color5"],
                            fontSize: 11.2,
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                          Config.langFulText.info!.bottomText!,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Config.langFulText.info!.step2Title!
                            .replaceAll("[name]", isim.toString()),
                        style: GoogleFonts.mukta(
                          fontSize: 28.8,
                          letterSpacing: -0.05,
                          height: 1.1,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"]!,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color2"],
                          border: Border.all(
                            width: 1,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["colorborder1"]!,
                          ),
                          borderRadius: BorderRadius.circular(12.8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                      Config.langFulText.general!.choose!,
                                      style: GoogleFonts.firaSans(
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
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
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
                                      color: ThemeColors.getColorTheme(Config
                                          .themType)["color10"], // Yazı rengi
                                      fontSize: 16,
                                    ),
                                    iconEnabledColor: ThemeColors.getColorTheme(
                                            Config.themType)[
                                        "color10"], // Aktif ikon rengi
                                    iconDisabledColor:
                                        ThemeColors.getColorTheme(
                                            Config.themType)["color10"],
                                    dropdownColor: ThemeColors.getColorTheme(
                                        Config.themType)["color2"],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
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
                                      color: ThemeColors.getColorTheme(Config
                                          .themType)["color10"], // Yazı rengi
                                      fontSize: 16,
                                    ),
                                    iconEnabledColor: ThemeColors.getColorTheme(
                                            Config.themType)[
                                        "color10"], // Aktif ikon rengi
                                    iconDisabledColor:
                                        ThemeColors.getColorTheme(
                                            Config.themType)["color10"],
                                    dropdownColor: ThemeColors.getColorTheme(
                                        Config.themType)["color2"],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              transform:
                                  Matrix4.translationValues(10.0, -68.0, 10.0),
                              child: Text(
                                Config.langFulText.general!.day!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color10"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              transform:
                                  Matrix4.translationValues(10.0, -68.0, 10.0),
                              child: Text(
                                Config.langFulText.general!.month!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color10"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              transform:
                                  Matrix4.translationValues(0.0, -68.0, 0.0),
                              child: Text(
                                Config.langFulText.general!.year!,
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color10"]!,
                                  fontSize: 12.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonText(
                          btnText: Config.langFulText.general!.next!,
                          bgColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"]!,
                          textColor: Colors.white,
                          onpress: () async {
                            if (gun == null || ay == null || yil == null) {
                              Config.genelModal(
                                context,
                                AlertBox(
                                  alertIcon: Icons.priority_high,
                                  alertColor: ThemeColors.getColorTheme(
                                      Config.themType)["colordanger"]!,
                                  title: Config.langFulText.general!.error!,
                                  content: Config.langFulText.info!
                                      .errorMessage!.birthday!,
                                  btnText: Config.langFulText.general!.okay!,
                                ),
                              );
                            } else {
                              _pageController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                active = 2;
                              });
                            }
                          }),
                      const Expanded(child: Text("")),
                      Text(
                        style: GoogleFonts.firaSans(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color5"],
                          fontSize: 11.2,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        Config.langFulText.info!.bottomText!,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Config.langFulText.info!.step3Title!,
                        style: GoogleFonts.mukta(
                          fontSize: 28.8,
                          height: 1.1,
                          letterSpacing: -0.05,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"]!,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            cinsiyet = "1";
                          });
                        },
                        tileColor: ThemeColors.getColorTheme(
                            Config.themType)["color2"],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["colorborder1"]!,
                              width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        title: Text(
                          Config.langFulText.general!.male!,
                          style: GoogleFonts.firaSans(
                            fontSize: 17.6,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        trailing: Radio(
                          value: "1",
                          activeColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"],
                          groupValue: cinsiyet,
                          onChanged: (value) {
                            setState(() {
                              cinsiyet = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            cinsiyet = "2";
                          });
                        },
                        tileColor: ThemeColors.getColorTheme(
                            Config.themType)["color2"],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["colorborder1"]!,
                              width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        title: Text(
                          Config.langFulText.general!.female!,
                          style: GoogleFonts.firaSans(
                            fontSize: 17.6,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        trailing: Radio(
                          value: "2",
                          activeColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"],
                          groupValue: cinsiyet,
                          onChanged: (value) {
                            setState(() {
                              cinsiyet = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "veya",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12.8,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color6"],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            cinsiyet = "3";
                          });
                        },
                        tileColor: ThemeColors.getColorTheme(
                            Config.themType)["color2"],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["colorborder1"]!,
                              width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        title: Text(
                          Config.langFulText.info!.dontWant!,
                          style: GoogleFonts.firaSans(
                            fontSize: 17.6,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        trailing: Radio(
                          value: "3",
                          groupValue: cinsiyet,
                          activeColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"],
                          onChanged: (value) {
                            setState(() {
                              cinsiyet = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ButtonText(
                          btnText: Config.langFulText.general!.complete!,
                          bgColor: ThemeColors.getColorTheme(
                              Config.themType)["colorprimary"]!,
                          textColor: Colors.white,
                          onpress: () async {
                            if (cinsiyet == null) {
                              Config.genelModal(
                                context,
                                AlertBox(
                                    alertIcon: Icons.priority_high,
                                    alertColor: ThemeColors.getColorTheme(
                                        Config.themType)["colordanger"]!,
                                    title: Config.langFulText.general!.error!,
                                    content: Config.langFulText.info!
                                        .errorMessage!.gender!,
                                    btnText: Config.langFulText.general!.okay!),
                              );
                            } else {
                              Config.genelModal(context, const LoadingModal());
                              var data = {
                                'lang': Config.lang,
                                'user_id': Config.userBilgi.userId,
                                'token': Config.userBilgi.token,
                                'name': isim,
                                'surname': soyisim,
                                'day': gun,
                                'month': ay,
                                'year': yil,
                                'gender': cinsiyet
                              };
                              var sonuc = await Httpservices()
                                  .postMethod("info/index.php", data);
                              var body = json.decode(sonuc);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              if (body["success"]) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushNamed("/home");
                              } else {
                                Config.genelModal(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  AlertBox(
                                      alertIcon: Icons.priority_high,
                                      alertColor: ThemeColors.getColorTheme(
                                          Config.themType)["colordanger"]!,
                                      title: Config.langFulText.general!.error!,
                                      content: body["message"],
                                      btnText:
                                          Config.langFulText.general!.okay!),
                                );
                              }
                            }
                            // Navigator.of(context).pushNamed("/home");
                          }),
                      const Expanded(child: Text("")),
                      Text(
                        style: GoogleFonts.firaSans(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color5"],
                          fontSize: 11.2,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        Config.langFulText.info!.bottomText!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 4,
                    color: (active == 0 || active == 1 || active == 2)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"]
                        : ThemeColors.getColorTheme(Config.themType)["color4"],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 4,
                    color: (active == 1 || active == 2)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"]
                        : ThemeColors.getColorTheme(Config.themType)["color4"],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 4,
                    color: (active == 2)
                        ? ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"]
                        : ThemeColors.getColorTheme(Config.themType)["color4"],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
