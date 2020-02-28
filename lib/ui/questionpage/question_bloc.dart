import 'dart:async';

import 'package:drives_licence/data/service/question_service.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/questionpage/viewstate.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  QuestionService questionService = GetIt.I<QuestionService>();

  QuestionBloc(Zlicense license) {
    getQuestions(license);
  }

  PublishSubject<List<Zquestion>> _questions = PublishSubject();
  Stream<List<Zquestion>> get questions => _questions.stream;

  PublishSubject<String> _time = PublishSubject();
  Stream<String> get time => _time.stream;

  PublishSubject<ViewState> _viewState = PublishSubject();
  Stream<ViewState> get viewState => _viewState.stream;

  void getQuestions(Zlicense license) async {
    final questions = await questionService.getQuestion(license.name);
    _questions.sink.add(questions);
    startTimer(license.duration.round());
  }

  Timer _timer;
  bool counting = true;

  void startTimer(int munites) {
    var timeInSeconds = munites * 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (!counting) {
        return;
      }
      if (timeInSeconds < 1) {
        _time.sink.add("00:00");
        timer.cancel();
        _viewState.sink.add(EventState(Event.TIME_OUT));
      } else {
        _time.sink.add(
            "${(timeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(timeInSeconds % 60).toString().padLeft(2, '0')}");
        timeInSeconds = timeInSeconds - 1;
      }
    });
  }

  void pauseTimer() {
    counting = false;
  }

  void resumeTimer() {
    counting = true;
  }

  void dispose() {
    _questions.close();
    _time.close();
    _viewState.close();
    _timer.cancel();
  }
}
