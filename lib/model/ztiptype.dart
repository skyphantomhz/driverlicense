class ZtipType {
  int pk;
  int ent;
  int opt;
  int index;
  String name;

  ZtipType({this.pk, this.ent, this.opt, this.index, this.name});

  ZtipType.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    index = int.parse(json['ZINDEX']);
    name = json['ZNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZINDEX'] = this.index.toString();
    data['ZNAME'] = this.name;
    return data;
  }
}