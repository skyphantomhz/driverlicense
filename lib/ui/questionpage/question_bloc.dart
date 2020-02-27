import 'package:drives_licence/data/service/question_service.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  QuestionService questionService = GetIt.I<QuestionService>();

  QuestionBloc(String licenseName) {
    getQuestions(licenseName);
  }

  PublishSubject<List<Zquestion>> _questions = PublishSubject();
  Stream<List<Zquestion>> get questions => _questions.stream;

  void getQuestions(String licenseName) async {
    final licenses = await questionService.getQuestion(licenseName);
    _questions.sink.add(licenses);
  }

  void dispose() {
    _questions.close();
  }
}
