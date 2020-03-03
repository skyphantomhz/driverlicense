import 'dart:convert';

import 'package:drives_licence/data/service/question_service.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestGeneratorBloc {
  QuestionService questionService = GetIt.I<QuestionService>();
  JsonDecoder _decoder = GetIt.I<JsonDecoder>();
  Zlicense _license;

  PublishSubject<List<Zquestion>> _questions = PublishSubject();
  Stream<List<Zquestion>> get questions => _questions.stream;

  void _getQuestions(Zlicense license) async {
    final questions = await questionService.getQuestion(license);
    _questions.sink.add(questions);
  }

  void dispose() {
    _questions.close();
  }

  void generateQuestions() async {
    final preferrence = await SharedPreferences.getInstance();
    _license = Zlicense.fromJson(
        _decoder.convert(await preferrence.get(PreferrenceKey.LICENSE)));
    _getQuestions(_license);
  }
}
