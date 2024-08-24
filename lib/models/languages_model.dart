import 'dart:convert';

import 'package:tryt/services/httpservices.dart';

class Languagesmodel {
  String? id;
  String? name;
  String? shortName;
  String? img;
  String? defaultLang;
  String? rtl;

  Languagesmodel(
      {this.id,
      this.name,
      this.shortName,
      this.img,
      this.defaultLang,
      this.rtl});

  Languagesmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    img = json['img'];
    defaultLang = json['default_lang'];
    rtl = json['rtl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = shortName;
    data['img'] = img;
    data['default_lang'] = defaultLang;
    data['rtl'] = rtl;
    return data;
  }
}

Future<List<Languagesmodel>> getLanguagesList() async {
  var sonuc = await Httpservices().postMethod("general/languages.php", {});
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Languagesmodel.fromJson(e)).toList();
}
