import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class ModelLikesModel {
  int? totalLike;
  bool? userLike;
  ModelLikesModel({
    this.totalLike,
    this.userLike,
  });

  ModelLikesModel.fromJson(Map<String, dynamic> json) {
    totalLike = json['total_like'];
    userLike = json['like'];
  }
}

class Modelsmodel {
  String? modelId;
  String? name;
  String? age;
  String? shortDescription;
  String? subcategory;
  String? img;
  String? totalLike;
  bool? userLike;
  int? purchased;
  Modelsmodel({
    this.modelId,
    this.name,
    this.age,
    this.shortDescription,
    this.subcategory,
    this.img,
    this.purchased,
    this.totalLike,
    this.userLike,
  });

  Modelsmodel.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    name = json['name'];
    age = json['age'];
    shortDescription = json['short_description'];
    subcategory = json['subcategory'];
    img = json['img'];
    purchased = json['purchased'];
    totalLike = json['total_like'];
    userLike = json['user_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_id'] = modelId;
    data['name'] = name;
    data['age'] = age;
    data['short_description'] = shortDescription;
    data['subcategory'] = subcategory;
    data['img'] = img;
    data['purchased'] = purchased;
    data['total_like'] = totalLike;
    data['user_like'] = userLike;
    return data;
  }
}

Future<List<Modelsmodel>> getGenderCatList(
    int page, String genderId, String genderCatId) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "gender_id": genderId,
    "category_id": genderCatId,
    "page": page.toString(),
  };
  var sonuc = await Httpservices().postMethod("models/index.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Modelsmodel.fromJson(e)).toList();
}

Future<ModelLikesModel> toggleModelLike({required String modelId}) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "model_id": modelId,
  };
  var result = await Httpservices().postMethod("models/model-like.php", data);
  var body = json.decode(result);
  print(body);
  var deger = body["result"] as Map<String, dynamic>;
  return ModelLikesModel.fromJson(deger);
}
