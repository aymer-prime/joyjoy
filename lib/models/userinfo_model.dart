class Userinfomodel {
  String? page;
  String? userId;
  String? token;
  String? email;

  Userinfomodel({this.page, this.userId, this.token, this.email});

  Userinfomodel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    userId = json['user_id'];
    token = json['token'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['user_id'] = userId;
    data['token'] = token;
    data['email'] = email;
    return data;
  }
}
