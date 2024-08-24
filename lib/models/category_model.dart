import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Categorymodel {
  String? id;
  String? name;
  String? description;
  String? link;
  String? img;

  Categorymodel({this.id, this.name, this.description, this.link, this.img});

  Categorymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    link = json['link'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['link'] = link;
    data['img'] = img;
    return data;
  }
}

Future<List<Categorymodel>> getGenderCatList() async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("choose/categories.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Categorymodel.fromJson(e)).toList();
}
