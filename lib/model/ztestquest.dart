class ZtestQuest {
  int pk;
  int testId;
  int questionId;
  String answer;
  String history;
  bool isCorrect;

  ZtestQuest(
      {this.pk,
      this.testId,
      this.questionId,
      this.answer,
      this.history,
      this.isCorrect});

  ZtestQuest.fromJson(Map<String, dynamic> json) {
    pk = json['ZTESTQUESTID'];
    testId = json['TESTID'];
    questionId = json['ZQUESTIONID'];
    answer = json['ZANSWER'];
    history = json['ZHISTORY'];
    isCorrect = false;
    final numberWrong = json['ZNUMBERWRONG'];
    if (numberWrong > 0) {
      isCorrect = true;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ZTESTQUESTID'] = this.pk;
    data['TESTID'] = this.testId;
    data['ZQUESTIONID'] = this.questionId;
    data['ZANSWER'] = this.answer;
    data['ZHISTORY'] = this.history;
    data['ZNUMBERWRONG'] = this.isCorrect ? 1 : 0;
    return data;
  }
}
