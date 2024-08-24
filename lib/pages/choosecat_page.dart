import 'package:tryt/components/choose_button.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/category_model.dart';
import 'package:tryt/pages/chooselist_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoosecatPage extends StatefulWidget {
  final String genderId;
  const ChoosecatPage({super.key, required this.genderId});

  @override
  State<ChoosecatPage> createState() => _ChoosecatPageState();
}

class _ChoosecatPageState extends State<ChoosecatPage> {
  List<Categorymodel> genderCatList = [];
  @override
  void initState() {
    super.initState();
    getPageLoad();
  }

  getPageLoad() async {
    var gendercat = await getGenderCatList();
    setState(() {
      genderCatList = gendercat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 0,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: 32,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      Config.langFulText.choose!.step2Title!,
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
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: genderCatList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  child: ChooseButton(
                      fontsize: 16,
                      fontWeights: FontWeight.w500,
                      borderradius: 12.8,
                      title: genderCatList[index].name!,
                      imageUrl: genderCatList[index].img!,
                      onpress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChooselistPage(
                              genderId: widget.genderId,
                              genderCatId: genderCatList[index].id!,
                              gendeCatDis: genderCatList[index].description!,
                              genderCatTitle: genderCatList[index].name!,
                            ),
                          ),
                        );
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
