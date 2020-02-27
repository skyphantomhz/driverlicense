class Zlicense {
  int pk;
  int ent;
  int opt;
  int numberOfCorrectQuestion;
  int numberOfQuestion;
  int numberOfTest;
  double duration;
  String content;
  String desc;
  String name;

  Zlicense(
      {this.pk,
      this.ent,
      this.opt,
      this.numberOfCorrectQuestion,
      this.numberOfQuestion,
      this.numberOfTest,
      this.duration,
      this.content,
      this.desc,
      this.name});

  Zlicense.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    numberOfCorrectQuestion = json['ZNUMBEROFCORRECTQUESTION'];
    numberOfQuestion = json['ZNUMBEROFQUESTION'];
    numberOfTest = json['ZNUMBEROFTEST'];
    duration = json['ZDURATION'];
    content = json['ZCONTENT'];
    desc = json['ZDESC'];
    name = json['ZNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZNUMBEROFCORRECTQUESTION'] = this.numberOfCorrectQuestion;
    data['ZNUMBEROFQUESTION'] = this.numberOfQuestion;
    data['ZNUMBEROFTEST'] = this.numberOfTest;
    data['ZDURATION'] = this.duration;
    data['ZCONTENT'] = this.content;
    data['ZDESC'] = this.desc;
    data['ZNAME'] = this.name;
    return data;
  }
}
