import 'dart:convert';

import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/data/service/history_service.dart';
import 'package:drives_licence/data/service/question_service.dart';
import 'package:drives_licence/model/zhistory.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class TestGeneratorBloc {
  QuestionService _questionService = GetIt.I<QuestionService>();
  HistoryService _historyService = GetIt.I<HistoryService>();
  Preferrence _preferrence = GetIt.I<Preferrence>();
  Zlicense _license;

  PublishSubject<List<Zquestion>> _questions = PublishSubject();
  Stream<List<Zquestion>> get questions => _questions.stream;

  PublishSubject<List<Zhistory>> _histories = PublishSubject();
  Stream<List<Zhistory>> get histories => _histories.stream;

  void _getQuestions(Zlicense license) async {
    final questions = await _questionService.getQuestion(license);
    _questions.sink.add(questions);
  }

  void dispose() {
    _questions.close();
    _histories.close();
  }

  void getHistories() async {
    final histories = await _historyService.histories();
    Future.delayed(Duration(milliseconds: 500), () {
      this._histories.sink.add(histories);
    });
  }

  void generateQuestions() async {
    _license = await _preferrence.license();
    _getQuestions(_license);
  }
}
