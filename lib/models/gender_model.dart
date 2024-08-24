import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Gendermodel {
  String? id;
  String? name;
  String? link;
  String? img;

  Gendermodel({this.id, this.name, this.link, this.img});

  Gendermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['img'] = img;
    return data;
  }
}

Future<List<Gendermodel>> getGenderList() async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("choose/genders.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Gendermodel.fromJson(e)).toList();
}
