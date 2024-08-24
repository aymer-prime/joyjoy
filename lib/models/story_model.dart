import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Storymodel {
  String? id;
  String? date;
  Model? model;
  List<Stories>? stories;

  Storymodel({this.id, this.date, this.model, this.stories});

  Storymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
  String? name;
  String? img;

  Model({this.name, this.img});

  Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    return data;
  }
}

class Stories {
  String? id;
  String? time;
  String? description;
  String? link;
  String? linkText;
  String? type;
  String? date;
  String? src;

  Stories(
      {this.id,
      this.time,
      this.description,
      this.link,
      this.linkText,
      this.type,
      this.date,
      this.src});

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    description = json['description'];
    link = json['link'];
    linkText = json['link_text'];
    type = json['type'];
    date = json['date'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['description'] = description;
    data['link'] = link;
    data['link_text'] = linkText;
    data['type'] = type;
    data['date'] = date;
    data['src'] = src;
    return data;
  }
}

Future<List<Storymodel>> getStoryListe() async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("story/index.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Storymodel.fromJson(e)).toList();
}
