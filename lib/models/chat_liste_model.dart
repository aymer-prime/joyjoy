import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Chatlistemodel {
  String? chatId;
  Model? model;
  LastMessage? lastMessage;

  Chatlistemodel({this.chatId, this.model, this.lastMessage});

  Chatlistemodel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    lastMessage = json['last_message'].length > 0
        ? LastMessage.fromJson(json['last_message'] ?? [])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    return data;
  }
}

class Model {
  String? modelId;
  String? name;
  String? subcategory;
  String? img;

  Model({this.modelId, this.name, this.subcategory, this.img});

  Model.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    name = json['name'];
    subcategory = json['subcategory'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_id'] = modelId;
    data['name'] = name;
    data['subcategory'] = subcategory;
    data['img'] = img;
    return data;
  }
}

class LastMessage {
  String? message;
  String? date;
  String? hour;

  LastMessage({this.message, this.date, this.hour});

  LastMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['date'] = date;
    data['hour'] = hour;
    return data;
  }
}

Future<List<Chatlistemodel>> getChatListe(int page) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "page": page.toString(),
  };
  var sonuc = await Httpservices().postMethod("tryt/index.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"] as List;
  return deger.map((e) => Chatlistemodel.fromJson(e)).toList();
}
