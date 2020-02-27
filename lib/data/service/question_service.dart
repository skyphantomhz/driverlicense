import 'package:drives_licence/data/localsource/dao/questiondao.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:get_it/get_it.dart';

class QuestionService {
  QuestionDao questionDao = GetIt.I<QuestionDao>();

  Future<List<Zquestion>> getQuestion(String licenseName) async {
    String questionFlat = getQuestionFlat(licenseName);
    return questionDao.questions(questionFlat);
  }
}
