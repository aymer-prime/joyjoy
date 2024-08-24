import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Myuserinfomodel {
  String? picture;
  String? name;
  String? surname;
  String? username;
  String? email;
  Birthday? birthday;
  String? gender;
  String? google;

  Myuserinfomodel(
      {this.picture,
      this.name,
      this.surname,
      this.username,
      this.email,
      this.birthday,
      this.gender,
      this.google});

  Myuserinfomodel.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    email = json['email'];
    birthday =
        json['birthday'] != null ? Birthday.fromJson(json['birthday']) : null;
    gender = json['gender'];
    google = json['google'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['picture'] = picture;
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['email'] = email;
    if (birthday != null) {
      data['birthday'] = birthday!.toJson();
    }
    data['gender'] = gender;
    data['google'] = google;
    return data;
  }
}

class Birthday {
  String? day;
  String? month;
  String? year;

  Birthday({this.day, this.month, this.year});

  Birthday.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}

Future<Myuserinfomodel> getUserInfo() async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("profile/info.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"];
  return Myuserinfomodel.fromJson(deger);
}
