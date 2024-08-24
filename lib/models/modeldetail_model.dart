import 'dart:convert';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';

class Modeldetailmodel {
  String? modelId;
  String? name;
  String? age;
  String? shortDescription;
  String? category;
  String? subcategory;
  String? img;

  Modeldetailmodel(
      {this.modelId,
      this.name,
      this.age,
      this.shortDescription,
      this.category,
      this.subcategory,
      this.img});

  Modeldetailmodel.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    name = json['name'];
    age = json['age'];
    shortDescription = json['short_description'];
    category = json['category'];
    subcategory = json['subcategory'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_id'] = modelId;
    data['name'] = name;
    data['age'] = age;
    data['short_description'] = shortDescription;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['img'] = img;
    return data;
  }
}

Future<Modeldetailmodel> getModalApi(
    String modelId, BuildContext context) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "model_id": modelId,
  };
  var sonuc = await Httpservices().postMethod("models/model-detail.php", data);
  var body = json.decode(sonuc);
  if (body["success"]) {
    return Modeldetailmodel.fromJson(body["result"]);
  } else {
    Navigator.pop(context);
    Config.genelModal(
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
    return Modeldetailmodel();
  }
}
