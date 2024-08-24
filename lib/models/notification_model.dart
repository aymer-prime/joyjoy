import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Notificationmodel {
  User? user;
  String? text;
  String? date;
  String? seen;

  Notificationmodel({this.user, this.text, this.date, this.seen});

  Notificationmodel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    text = json['text'];
    date = json['date'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['text'] = text;
    data['date'] = date;
    data['seen'] = seen;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? img;

  User({this.id, this.username, this.img});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['img'] = img;
    return data;
  }
}

Future<List<Notificationmodel>> getNotifications() async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("notifications/index.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Notificationmodel.fromJson(e)).toList();
}
