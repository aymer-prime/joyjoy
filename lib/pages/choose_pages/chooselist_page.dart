import 'package:get/get.dart';
import 'package:tryt/components/userliste_card.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/category_model.dart';
import 'package:tryt/models/models_model.dart' as models;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/pages/model_details/model_detay_page.dart';

class ChooselistPage extends StatefulWidget {
  final String Function() getGenderId;
  final Categorymodel Function() categorymodel;
  final VoidCallback onBack;
  const ChooselistPage({
    super.key,
    required this.getGenderId,
    required this.categorymodel,
    required this.onBack,
  });

  @override
  State<ChooselistPage> createState() => _ChooselistPageState();
}

class _ChooselistPageState extends State<ChooselistPage> {
  late String genderId;
  late Categorymodel categorymodel;
  List<models.Modelsmodel> modelListe = [
    models.Modelsmodel(name: "appTitle"),
    models.Modelsmodel(name: "text10x")
  ];
  int page = 0;
  bool loadingpage = true;
  @override
  void initState() {
    genderId = widget.getGenderId();
    categorymodel = widget.categorymodel();
    super.initState();
    getPageLoad(page);
  }

  getPageLoad(int page) async {
    var getmodeller = await models.getGenderCatList(
      page,
      genderId,
      categorymodel.id!,
    );
    setState(() {
      modelListe.addAll(getmodeller);
      loadingpage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: modelListe.length,
        itemBuilder: (context, index) {
          if (modelListe[index].name == "appTitle") {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      widget.onBack();
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
                  text: categorymodel.name,
                  style: GoogleFonts.firaSans(
                    fontSize: 14.4,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                  ),
                  children: [
                    TextSpan(
                      text: " ${categorymodel.description}",
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
              modelId: modelListe[index].modelId ?? '',
              title: modelListe[index].name ?? '',
              subcategory: modelListe[index].subcategory ?? '',
              yas: modelListe[index].age ?? '',
              subTitle: modelListe[index].shortDescription ?? '',
              imageUrl: modelListe[index].img ?? '',
              liked: modelListe[index].userLike ?? false,
              numLikes: modelListe[index].totalLike ?? '',
              onpress: () {
                Get.to(
                  ModelDetayPage(
                    modelId: modelListe[index].modelId!,
                  ),
                );
                // Navigator.of(
                //   context,
                //   rootNavigator: true,
                // ).pushNamed("/model-detail/${modelListe[index].modelId}");
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
    );
  }
}
