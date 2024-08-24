class FileModel {
  String? duration;
  String? path;

  FileModel({this.duration, this.path});

  FileModel.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['path'] = path;
    return data;
  }
}
