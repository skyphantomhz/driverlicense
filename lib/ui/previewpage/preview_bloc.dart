import 'dart:math';

import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/data/service/history_service.dart';
import 'package:drives_licence/data/service/test_service.dart';
import 'package:drives_licence/model/zhistory.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/previewpage/preview_page.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class PreviewBloc {
  HistoryService historyService = GetIt.I<HistoryService>();
  TestService testService = GetIt.I<TestService>();
  Preferrence preferrence = GetIt.I<Preferrence>();

  PublishSubject<String> _correctAnswers = PublishSubject<String>();
  Stream<String> get correctAnswers => _correctAnswers.stream;

  PublishSubject<bool> _pass = PublishSubject<bool>();
  Stream<bool> get pass => _pass.stream;

  Zlicense _license;

  PreviewBloc(PreviewArguments previewArguments) {
    _initAsync(previewArguments);
  }

  void _initAsync(PreviewArguments previewArguments) async {
    _license = await preferrence.license();
    final correctAnswer = _calculateCorrectAnswers(previewArguments.questions);
    _saveTestHistory(correctAnswer, previewArguments.timeInMinutes);
    testService.insertTest(previewArguments.questions, Random().nextInt(100), (previewArguments.timeInMinutes*60).toInt());
  }

  int _calculateCorrectAnswers(List<Zquestion> questions) {
    var correctAnswers = 0;
    questions?.forEach((item) {
      if (item.isCorrect() == true) {
        ++correctAnswers;
      }
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      final message = "Your correct answers: $correctAnswers/20";
      _correctAnswers.sink.add(message);
      _pass.sink.add(correctAnswers >= _license.numberOfCorrectQuestion);
    });
    return correctAnswers;
  }

  void _saveTestHistory(int correctAnswer, double time) {
    final numberOfFalse = _license.numberOfQuestion - correctAnswer;
    final result = correctAnswer >= _license.numberOfCorrectQuestion ? 1 : 0;
    final testHistory = Zhistory(
        numberTrue: correctAnswer,
        numberOfFalse: numberOfFalse,
        result: result,
        license: _license.pk,
        time: time);
    historyService.insertHistory(testHistory);
  }

  void dispose() {
    _correctAnswers.close();
    _pass.close();
  }
}
