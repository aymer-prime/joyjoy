import 'dart:convert';
import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';

class Feedmodel {
  String? id;
  String? text;
  String? totalLike;
  String? totalComment;
  String? totalShare;
  String? date;
  List<Media>? media;
  bool? userLike;
  Model? model;

  Feedmodel(
      {this.id,
      this.text,
      this.totalLike,
      this.totalComment,
      this.totalShare,
      this.date,
      this.media,
      this.userLike,
      this.model});

  Feedmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'] ?? '';
    totalLike = json['total_like'];
    totalComment = json['total_comment'];
    totalShare = json['total_share'];
    date = json['date'];
    if (json['media'] != null) {
      media = (json['media'] as List).map((i) => Media.fromJson(i)).toList();
    } else {
      media = [];
    }
    userLike = json['user_like'];
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['total_like'] = totalLike;
    data['total_comment'] = totalComment;
    data['total_share'] = totalShare;
    data['date'] = date;
    if (media != null) {
      data['media'] = media!.map((e) => e.toJson()).toList();
    }
    data['user_like'] = userLike;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    return data;
  }
}

class Media {
  String? src;
  int? video;
  String? videoThumb;

  Media({this.src, this.video, this.videoThumb});

  Media.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    video = json['video'];
    videoThumb = json['video_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['video'] = video;
    data['video_thumb'] = videoThumb;
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

Future<List<Feedmodel>> getFeedListe(int pageId) async {
  var data = {
    "user_id": Config.userBilgi.userId,
    "token": Config.userBilgi.token,
    "page": pageId.toString(),
    "lang": Config.lang,
  };
  var sonuc = await Httpservices().postMethod("feed/index.php", data);
  var body = json.decode(sonuc);
  print('feed body:$body');
  var deger = body["result"] as List;
  return deger.map((e) => Feedmodel.fromJson(e)).toList();
}
