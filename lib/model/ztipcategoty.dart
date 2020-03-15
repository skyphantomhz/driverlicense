class ZtipCategory {
  int pk;
  int ent;
  int opt;
  int tipType;
  int index;
  String name;
  bool isExpand = false;

  ZtipCategory(
      {this.pk, this.ent, this.opt, this.tipType, this.index, this.name});

  ZtipCategory.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    tipType = json['ZTIPTYPE'];
    index = int.parse(json['ZINDEX']);
    name = json['ZNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZTIPTYPE'] = this.tipType;
    data['ZINDEX'] = this.index.toString();
    data['ZNAME'] = this.name;
    return data;
  }
}