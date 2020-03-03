import 'dart:async';

import 'package:drives_licence/data/localsource/dao/questiondao.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/znumberquestionpertype.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:get_it/get_it.dart';

class QuestionService {
  QuestionDao questionDao = GetIt.I<QuestionDao>();

  Future<List<Zquestion>> getQuestion(Zlicense license) async {
    final completer = Completer<List<Zquestion>>();
    final questions = List<Zquestion>();
    final questionTypes = await getNumberQuestionPerType(license.pk);
    questionTypes.forEach((questionType) async {
      final questionOfType = await getQuestionsPerType(
          license.name, questionType.questionType, questionType.count);
      questions.addAll(questionOfType);
      if (questionTypes.last == questionType) {
        completer.complete(questions);
      }
    });
    return completer.future;
  }

  Future<List<ZnumberQuestionPerType>> getNumberQuestionPerType(
      int licenseId) async {
    return questionDao.numberQuestionPerType(licenseId);
  }

  Future<List<Zquestion>> getQuestionsPerType(
      String licenseName, int questionTypeId, int count) async {
    return questionDao.getQuestionsPerType(
        getQuestionFlat(licenseName), questionTypeId, count);
  }
}
