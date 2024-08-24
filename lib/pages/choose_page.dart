import 'package:tryt/components/choose_button.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/gender_model.dart';
import 'package:tryt/pages/choosecat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  List<Gendermodel> genderliste = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGender();
  }

  getGender() async {
    var genderler = await getGenderList();
    setState(() {
      genderliste = genderler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: (genderliste.isNotEmpty)
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              Config.langFulText.choose!.step1Title!,
                              style: GoogleFonts.mukta(
                                fontSize: 22,
                                height: 1.1,
                                letterSpacing: -0.8,
                                color: ThemeColors.getColorTheme(
                                    Config.themType)["color10"],
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ChooseButton(
                        onpress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChoosecatPage(
                                genderId: genderliste[0].id.toString(),
                              ),
                            ),
                          );
                        },
                        imageUrl: genderliste[0].img.toString(),
                        title: genderliste[0].name.toString(),
                        fontsize: 32,
                        borderradius: 12.8,
                        fontWeights: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ChooseButton(
                        onpress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChoosecatPage(
                                    genderId: genderliste[1].id.toString(),
                                  )));
                        },
                        title: genderliste[1].name.toString(),
                        imageUrl: genderliste[1].img.toString(),
                        fontsize: 32,
                        borderradius: 12.8,
                        fontWeights: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
