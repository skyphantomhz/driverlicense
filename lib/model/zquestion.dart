class Zquestion {
  int pk;
  int ent;
  int opt;
  int includeA1;
  int includeA2;
  int includeA3A4;
  int includeB1;
  int index;
  int learned;
  int marked;
  int wrong;
  int questionType;
  String answerDesc;
  String answers;
  String awsA1;
  String awsA2;
  String awsA34;
  String awsB1;
  String awsB2CDEF;
  String image;
  String option1;
  String option2;
  String option3;
  String option4;
  String questionContent;
  Set<int> answerSubmited;

  Zquestion(
      {this.pk,
      this.ent,
      this.opt,
      this.includeA1,
      this.includeA2,
      this.includeA3A4,
      this.includeB1,
      this.index,
      this.learned,
      this.marked,
      this.wrong,
      this.questionType,
      this.answerDesc,
      this.answers,
      this.awsA1,
      this.awsA2,
      this.awsA34,
      this.awsB1,
      this.awsB2CDEF,
      this.image,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.questionContent});

  Zquestion.fromJson(Map<String, dynamic> json) {
    pk = json['Z_PK'];
    ent = json['Z_ENT'];
    opt = json['Z_OPT'];
    includeA1 = json['ZINCLUDEA1'];
    includeA2 = json['ZINCLUDEA2'];
    includeA3A4 = json['ZINCLUDEA3A4'];
    includeB1 = json['ZINCLUDEB1'];
    index = json['ZINDEX'];
    learned = json['ZLEARNED'];
    marked = json['ZMARKED'];
    wrong = json['ZWRONG'];
    questionType = json['ZQUESTIONTYPE'];
    answerDesc = json['ZANSWERDESC'];
    answers = json['ZANSWERS'];
    awsA1 = json['ZAWSA1'];
    awsA2 = json['ZAWSA2'];
    awsA34 = json['ZAWSA34'];
    awsB1 = json['ZAWSB1'];
    awsB2CDEF = json['ZAWSB2CDEF'];
    image = json['ZIMAGE'];
    option1 = json['ZOPTION1'];
    option2 = json['ZOPTION2'];
    option3 = json['ZOPTION3'];
    option4 = json['ZOPTION4'];
    questionContent = json['ZQUESTIONCONTENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Z_PK'] = this.pk;
    data['Z_ENT'] = this.ent;
    data['Z_OPT'] = this.opt;
    data['ZINCLUDEA1'] = this.includeA1;
    data['ZINCLUDEA2'] = this.includeA2;
    data['ZINCLUDEA3A4'] = this.includeA3A4;
    data['ZINCLUDEB1'] = this.includeB1;
    data['ZINDEX'] = this.index;
    data['ZLEARNED'] = this.learned;
    data['ZMARKED'] = this.marked;
    data['ZWRONG'] = this.wrong;
    data['ZQUESTIONTYPE'] = this.questionType;
    data['ZANSWERDESC'] = this.answerDesc;
    data['ZANSWERS'] = this.answers;
    data['ZAWSA1'] = this.awsA1;
    data['ZAWSA2'] = this.awsA2;
    data['ZAWSA34'] = this.awsA34;
    data['ZAWSB1'] = this.awsB1;
    data['ZAWSB2CDEF'] = this.awsB2CDEF;
    data['ZIMAGE'] = this.image;
    data['ZOPTION1'] = this.option1;
    data['ZOPTION2'] = this.option2;
    data['ZOPTION3'] = this.option3;
    data['ZOPTION4'] = this.option4;
    data['ZQUESTIONCONTENT'] = this.questionContent;
    return data;
  }

  String getOption(int index) {
    switch (index) {
      case 0:
        return option1;
        break;
      case 1:
        return option2;
        break;
      case 2:
        return option3;
        break;
      default:
        return option4;
    }
  }

  bool isCorrect() {
    answerSubmited?.toList()?.sort((a, b) => a.compareTo(b));
    final answerSubmitedStr = answerSubmit();
    return answerSubmitedStr != null && answerSubmitedStr == answers;
  }

  String answerSubmit(){
    return answerSubmited?.map((answer) => answer.toString())?.join(',');
  }
}
