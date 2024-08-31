import 'package:get/get.dart';
import 'package:tryt/components/choose_button.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/category_model.dart';
import 'package:tryt/models/gender_model.dart';
import 'package:tryt/pages/choose_pages/choosecat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/pages/choose_pages/chooselist_page.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  List<Gendermodel> genderList = [];
  late final PageController controller;
  late String genderId;
  late Categorymodel categoryModel;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    getGender();
  }

  getGender() async {
    var genderler = await getGenderList();
    genderId = genderler[1].id.toString();
    setState(() {
      genderList = genderler;
    });
  }

  String get gender {
    return genderId;
  }

  Categorymodel get category {
    return categoryModel;
  }

  void navigateToCategories(String id) {
    genderId = id;
    controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCirc,
    );
  }

  void navigateToChooseLists(Categorymodel catModel) {
    categoryModel = catModel;
    controller.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCirc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: (genderList.isNotEmpty)
              ? PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ChooseListGender(
                      genderList: genderList,
                      onGenderChoose: navigateToCategories,
                    ),
                    ChoosecatPage(
                      getGenderId: () {
                        return gender;
                      },
                      onBack: () {
                        controller.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOutCirc);
                      },
                      onCatigoryChoose: navigateToChooseLists,
                    ),
                    ChooselistPage(
                      getGenderId: () {
                        return gender;
                      },
                      categorymodel: () {
                        return category;
                      },
                      onBack: () {
                        controller.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOutCirc);
                      },
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

class ChooseListGender extends StatelessWidget {
  final List<Gendermodel> genderList;
  final void Function(String) onGenderChoose;
  const ChooseListGender({
    super.key,
    required this.genderList,
    required this.onGenderChoose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
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
              onGenderChoose(genderList[0].id.toString());
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ChoosecatPage(
              //       genderId: genderList[0].id.toString(),
              //     ),
              //   ),
              // );
            },
            imageUrl: genderList[0].img.toString(),
            title: genderList[0].name.toString(),
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
              onGenderChoose(genderList[1].id.toString());
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChoosecatPage(
              //           genderId: genderliste[1].id.toString(),
              //         )));
            },
            title: genderList[1].name.toString(),
            imageUrl: genderList[1].img.toString(),
            fontsize: 32,
            borderradius: 12.8,
            fontWeights: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
