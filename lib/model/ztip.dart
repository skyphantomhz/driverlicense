class Ztip {
  int pk;
  int ent;
  int opt;
  int tipCategory;
  String content;
  String desc;
  int index;

  Ztip(
      {this.pk,
      this.ent,
      this.opt,
      this.tipCategory,
      this.content,
      this.desc,
      this.index});

  Ztip.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    tipCategory = json['ZTIPCATEGORY'];
    content = json['ZCONTENT'];
    desc = json['ZDESC'];
    index = int.parse(json['ZINDEX']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZTIPCATEGORY'] = this.tipCategory;
    data['ZCONTENT'] = this.content;
    data['ZDESC'] = this.desc;
    data['ZINDEX'] = this.index.toString();
    return data;
  }
}