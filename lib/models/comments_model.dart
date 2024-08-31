import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Commentsmodel {
  String? id;
  User? user;
  String? comment;
  String? totalLike;
  String? totalReply;
  String? date;
  String? status;

  Commentsmodel(
      {this.id,
      this.user,
      this.comment,
      this.totalLike,
      this.totalReply,
      this.date,
      this.status});

  Commentsmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    comment = json['comment'];
    totalLike = json['total_like'];
    totalReply = json['total_reply'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['comment'] = comment;
    data['total_like'] = totalLike;
    data['total_reply'] = totalReply;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}

class SubCommentsmodel {
  String? id;
  User? user;
  String? comment;
  String? totalLike;
  String? date;
  String? status;

  SubCommentsmodel(
      {this.id,
      this.user,
      this.comment,
      this.totalLike,
      this.date,
      this.status});

  SubCommentsmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    comment = json['comment'];
    totalLike = json['total_like'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['comment'] = comment;
    data['total_like'] = totalLike;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? img;
  bool? userLike;

  User({this.id, this.username, this.img, this.userLike});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    img = json['img'];
    userLike = json['user_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['img'] = img;
    data['user_like'] = userLike;
    return data;
  }
}

Future<List<Commentsmodel>> getCommentsList(String page, feedId) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "feed_id": feedId,
    "page": page,
  };
  var sonuc = await Httpservices().postMethod("feed/comments.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"]["comments"] as List;
  return deger.map((e) => Commentsmodel.fromJson(e)).toList();
}

Future<List<SubCommentsmodel>> getSubCommentsListe(
    String page, commentId) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "lang": Config.lang,
    "comment_id": commentId,
    "page": page,
  };
  var sonuc = await Httpservices().postMethod("feed/comments-replys.php", data);
  var body = json.decode(sonuc);
  var deger = body["result"]["replys"] as List;
  return deger.map((e) => SubCommentsmodel.fromJson(e)).toList();
}
