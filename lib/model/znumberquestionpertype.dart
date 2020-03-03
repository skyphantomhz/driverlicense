class ZnumberQuestionPerType {
  int pk;
  int ent;
  int opt;
  int count;
  int licenseId;
  int questionType;

  ZnumberQuestionPerType(
      {this.pk,
      this.ent,
      this.opt,
      this.count,
      this.licenseId,
      this.questionType});

  ZnumberQuestionPerType.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    count = json['ZCOUNT'];
    licenseId = json['ZLICENSE'];
    questionType = json['ZQUESTIONTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZCOUNT'] = this.count;
    data['ZLICENSE'] = this.licenseId;
    data['ZQUESTIONTYPE'] = this.questionType;
    return data;
  }
}
