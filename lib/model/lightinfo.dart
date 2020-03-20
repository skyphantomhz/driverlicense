class LightInfo {
  int id;
  String description;
  String detail;

  LightInfo({this.id, this.description, this.detail});

  LightInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['detail'] = this.detail;
    return data;
  }
}