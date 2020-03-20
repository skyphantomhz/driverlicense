class Ztest {
  int pk;
  int testName;
  int currentQuest;
  int licenseId;
  int currentTime;
  int timeHis;
  int totalSuccess;
  int isFinish;

  Ztest(
      {this.pk,
      this.testName,
      this.currentQuest,
      this.licenseId,
      this.currentTime,
      this.timeHis,
      this.totalSuccess,
      this.isFinish});

  Ztest.fromJson(Map<String, dynamic> json) {
    pk = json['IDTEST'];
    testName = json['NAME_TEST'];
    currentQuest = json['ZCURRENT_QUEST'];
    licenseId = int.parse(json['CLASS_LICENSE']);
    currentTime = json['CURRENT_TIME'];
    timeHis = int.parse(json['TIME_HIS']);
    totalSuccess = json['TOTAL_SUCCESS'];
    isFinish = json['ISFINISH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDTEST'] = this.pk;
    data['NAME_TEST'] = this.testName;
    data['ZCURRENT_QUEST'] = this.currentQuest;
    data['CLASS_LICENSE'] = this.licenseId.toString();
    data['CURRENT_TIME'] = this.currentTime;
    data['TIME_HIS'] = this.timeHis.toString();
    data['TOTAL_SUCCESS'] = this.totalSuccess;
    data['ISFINISH'] = this.isFinish;
    return data;
  }
}