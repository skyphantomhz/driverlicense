class Zsign {
  int pk;
  int ent;
  int opt;
  int signCategory;
  String desc;
  String image;
  int index;
  String name;

  Zsign(
      {this.pk,
      this.ent,
      this.opt,
      this.signCategory,
      this.desc,
      this.image,
      this.index,
      this.name});

  Zsign.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    signCategory = json['ZSIGNCATEGORY'];
    desc = json['ZDESC'];
    image = json['ZIMAGE'];
    index = int.parse(json['ZINDEX']);
    name = json['ZNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZSIGNCATEGORY'] = this.signCategory;
    data['ZDESC'] = this.desc;
    data['ZIMAGE'] = this.image;
    data['ZINDEX'] = this.index.toString();
    data['ZNAME'] = this.name;
    return data;
  }
}