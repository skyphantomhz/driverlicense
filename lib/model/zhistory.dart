class Zhistory {
  int pk;
  int ent;
  int opt;
  int indexOfTest;
  int numberOfFalse;
  int numberTrue;
  int result;
  int license;
  double time;

  Zhistory(
      {this.pk,
      this.ent,
      this.opt,
      this.indexOfTest,
      this.numberOfFalse,
      this.numberTrue,
      this.result,
      this.license,
      this.time});

  Zhistory.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    indexOfTest = json['ZINDEXOFTEST'];
    numberOfFalse = json['ZNUMBEROFFALSE'];
    numberTrue = json['ZNUMBERTRUE'];
    result = json['ZRESULT'];
    license = json['ZLICENSE'];
    time = json['ZTIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZINDEXOFTEST'] = this.indexOfTest;
    data['ZNUMBEROFFALSE'] = this.numberOfFalse;
    data['ZNUMBERTRUE'] = this.numberTrue;
    data['ZRESULT'] = this.result;
    data['ZLICENSE'] = this.license;
    data['ZTIME'] = this.time;
    return data;
  }
}
