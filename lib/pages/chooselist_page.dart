import 'package:tryt/components/userliste_card.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/models_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooselistPage extends StatefulWidget {
  final String genderId, genderCatId, gendeCatDis, genderCatTitle;
  const ChooselistPage(
      {super.key,
      required this.genderId,
      required this.genderCatId,
      required this.gendeCatDis,
      required this.genderCatTitle});

  @override
  State<ChooselistPage> createState() => _ChooselistPageState();
}

class _ChooselistPageState extends State<ChooselistPage> {
  List<Modelsmodel> modelListe = [
    Modelsmodel(name: "appTitle"),
    Modelsmodel(name: "text10x")
  ];
  int page = 0;
  bool loadingpage = true;
  @override
  void initState() {
    super.initState();
    getPageLoad(page);
  }

  getPageLoad(int page) async {
    var getmodeller =
        await getGenderCatList(page, widget.genderId, widget.genderCatId);
    setState(() {
      modelListe.addAll(getmodeller);
      loadingpage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 0,
        ),
        child: ListView.builder(
          itemCount: modelListe.length,
          itemBuilder: (context, index) {
            if (modelListe[index].name == "appTitle") {
              return Padding(
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
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        Config.langFulText.choose!.step3Title!,
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
              );
            } else if (modelListe[index].name == "text10x") {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.8),
                  color: ThemeColors.getColorTheme(Config.themType)["color3"],
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: widget.genderCatTitle,
                    style: GoogleFonts.firaSans(
                      fontSize: 14.4,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                    children: [
                      TextSpan(
                        text: " ${widget.gendeCatDis}",
                        style: GoogleFonts.firaSans(
                          fontSize: 14.4,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.only(
                bottom: 16,
              ),
              child: UserlisteCard(
                title: modelListe[index].name ?? '',
                yas: modelListe[index].age ?? '',
                //todo null check operator
                subTitle: modelListe[index].shortDescription ?? '',
                imageUrl: modelListe[index].img ?? '',
                onpress: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed("/model-detail/${modelListe[index].modelId}");
                  // Config.modalCenter(
                  //   context,
                  //   UserModalProfil(
                  //     modelId: modelListe[index].modelId!,
                  //   ),
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
