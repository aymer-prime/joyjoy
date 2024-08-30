import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/lang_string_model.dart';
import 'package:tryt/models/languages_model.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String themMod = Config.themType, lang = Config.lang;
  List<Languagesmodel> _languagesList = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  loadPage() async {
    var lng = await getLanguagesList();
    setState(() {
      _languagesList = lng;
      loading = false;
    });
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
                Config.langFulText.settings!.pageTitle!,
                style: GoogleFonts.mukta(
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  fontWeight: FontWeight.w800,
                  fontSize: 23,
                ),
              ),
            ),
          ];
        },
        body: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Text(
                      Config.langFulText.general!.language!,
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color2"],
                      border: Border.all(
                        width: 1,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["colorborder1"]!,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                        items: _languagesList.map((deger) {
                          return DropdownMenuItem<String>(
                            value: deger.shortName,
                            child: Text(deger.name!),
                          );
                        }).toList(),
                        value: lang,
                        onChanged: (String? yeniSecim) {
                          setState(() {
                            lang = yeniSecim!;
                          });
                        },
                        style: TextStyle(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                        ),
                        iconEnabledColor: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        iconDisabledColor: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        dropdownColor: ThemeColors.getColorTheme(
                            Config.themType)["color2"],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Text(
                      Config.langFulText.settings!.theme!.title!,
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        themMod = "system";
                      });
                    },
                    tileColor:
                        ThemeColors.getColorTheme(Config.themType)["color2"],
                    contentPadding: const EdgeInsets.only(left: 32, right: 32),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["colorborder1"]!,
                          width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    title: Text(
                      Config.langFulText.settings!.theme!.auto!,
                      style: GoogleFonts.firaSans(
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    trailing: Radio(
                      value: "system",
                      groupValue: themMod,
                      activeColor: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                      onChanged: (value) {
                        setState(() {
                          themMod = value!;
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
                        themMod = "light";
                      });
                    },
                    contentPadding: const EdgeInsets.only(left: 32, right: 32),
                    tileColor:
                        ThemeColors.getColorTheme(Config.themType)["color2"],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["colorborder1"]!,
                          width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    title: Text(
                      Config.langFulText.settings!.theme!.light!,
                      style: GoogleFonts.firaSans(
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    trailing: Radio(
                      value: "light",
                      groupValue: themMod,
                      activeColor: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                      onChanged: (value) {
                        setState(() {
                          themMod = value!;
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
                        themMod = "dark";
                      });
                    },
                    contentPadding: const EdgeInsets.only(left: 32, right: 32),
                    tileColor:
                        ThemeColors.getColorTheme(Config.themType)["color2"],
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["colorborder1"]!,
                          width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    title: Text(
                      Config.langFulText.settings!.theme!.dark!,
                      style: GoogleFonts.firaSans(
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    trailing: Radio(
                      value: "dark",
                      activeColor: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                      groupValue: themMod,
                      onChanged: (value) {
                        setState(() {
                          themMod = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ButtonText(
                    onpress: () async {
                      await PrefService().setString("sysTeme", themMod);
                      await PrefService().setString("systhemLang", lang);
                      var data = await getLangFulTextApi(lang);
                      setState(() {
                        Config.themType = themMod;
                        Config.lang = lang;
                        Config.langFulText = data;
                      });

                      Phoenix.rebirth(context);
                    },
                    btnText: Config.langFulText.general!.save!,
                    bgColor: ThemeColors.getColorTheme(
                        Config.themType)["colorprimary"]!,
                    textColor: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
