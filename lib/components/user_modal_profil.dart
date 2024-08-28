import 'dart:convert';

import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/components/userliste_card.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/modeldetail_model.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';

class UserModalProfil extends StatefulWidget {
  final String modelId;
  const UserModalProfil({super.key, required this.modelId});

  @override
  State<UserModalProfil> createState() => _UserModalProfilState();
}

class _UserModalProfilState extends State<UserModalProfil> {
  List<Modeldetailmodel> modelbilgi = [];
  bool clickStatus = true;
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  loadPage() async {
    var modelinfo = await getModalApi(widget.modelId, context);
    setState(() {
      modelbilgi.add(modelinfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (modelbilgi.isNotEmpty)
        ? Container(
            margin: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ThemeColors.getColorTheme(Config.themType)["color1"],
              border: Border.all(
                  width: 12.8,
                  color: ThemeColors.getColorTheme(Config.themType)["color1"]!),
              borderRadius: BorderRadius.circular(12.8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserlisteCard(
                  title: modelbilgi[0].name ?? '',
                  yas: modelbilgi[0].age ?? '',
                  subTitle: modelbilgi[0].shortDescription ?? '',
                  imageUrl: modelbilgi[0].img ?? '',
                  onpress: () {},
                ),
                const SizedBox(
                  height: 12.8,
                ),
                ButtonText(
                  onpress: (clickStatus == true)
                      ? () async {
                          setState(() {
                            clickStatus = false;
                          });
                          var data = {
                            "user_id": Config.userBilgi.userId,
                            "token": Config.userBilgi.token,
                            "lang": Config.lang,
                            "model_id": modelbilgi[0].modelId,
                          };
                          var sonuc = await Httpservices()
                              .postMethod("models/select-model.php", data);
                          var body = json.decode(sonuc);
                          if (body["success"]) {
                            var data = body["result"]["page"].split("/");
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed("/chatDetail/${data[1]}");
                          } else {
                            print("Satın alma Ekranı Açılacak galiba");
                          }
                        }
                      : null,
                  btnText: Config.langFulText.general!.startTalking!,
                  bgColor: ThemeColors.getColorTheme(
                      Config.themType)["colorprimary"]!,
                  textColor: Colors.white,
                ),
              ],
            ),
          )
        : const LoadingModal();
  }
}
