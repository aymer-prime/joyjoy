import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Chatdetailmodel {
  Model? model;
  String? chatId;
  List<ChatHistory>? chatHistory;

  Chatdetailmodel({this.model, this.chatId, this.chatHistory});

  Chatdetailmodel.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    chatId = json['chat_id'];
    if (json['chat_history'] != null) {
      chatHistory = <ChatHistory>[];
      json['chat_history'].forEach((v) {
        chatHistory!.add(ChatHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toJson();
    }
    data['chat_id'] = chatId;
    if (chatHistory != null) {
      data['chat_history'] = chatHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
  String? id;
  String? name;
  String? subcategory;
  String? img;

  Model({this.id, this.name, this.subcategory, this.img});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subcategory = json['subcategory'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['subcategory'] = subcategory;
    data['img'] = img;
    return data;
  }
}

class ChatHistory {
  String? user;
  String? message;
  String? date;
  String? image;
  String? imageUrl;

  ChatHistory({this.user, this.message, this.date, this.image, this.imageUrl});

  ChatHistory.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    message = json['message'];
    date = json['date'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['message'] = message;
    data['date'] = date;
    data['image'] = image;
    data['image_url'] = imageUrl;
    return data;
  }
}

Future<Chatdetailmodel> getChatDetailListe(String chatId, int page) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "chat_id": chatId,
    "page": page.toString(),
  };
  var sonuc = await Httpservices().postMethod("tryt/detail.php", data);
  var body = json.decode(sonuc);
  // var deger = body["result"] as List;
  return Chatdetailmodel.fromJson(body["result"]);
}

Future<List<ChatHistory>> getChatDetailNextListe(
    String chatId, int page) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "chat_id": chatId,
    "page": page.toString(),
  };
  var sonuc = await Httpservices().postMethod("tryt/detail.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"]["chat_history"] as List;
  return deger.map((e) => ChatHistory.fromJson(e)).toList();
}
