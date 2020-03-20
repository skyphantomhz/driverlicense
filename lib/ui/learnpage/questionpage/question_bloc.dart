import 'dart:async';
import 'dart:convert';

import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/learnpage/questionpage/viewstate.dart';
import 'package:drives_licence/util/time_util.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBloc {
  Zlicense _license;
  JsonDecoder _decoder = GetIt.I<JsonDecoder>();
  QuestionBloc() {
    _initView();
  }

  void _initView() async {
    final preferrence = await SharedPreferences.getInstance();
    final licenseJson = await preferrence.get(PreferrenceKey.LICENSE);
    _license = Zlicense.fromJson(_decoder.convert(licenseJson));
    startTimer(_license.duration.round());

    Future.delayed(Duration(milliseconds: 500), () {
      sendPageState(0);
    });
  }

  PublishSubject<String> _time = PublishSubject();
  Stream<String> get time => _time.stream;

  PublishSubject<ViewState> _viewState = PublishSubject();
  Stream<ViewState> get viewState => _viewState.stream;

  PublishSubject<String> _pageState = PublishSubject();
  Stream<String> get pageState => _pageState.stream;

  Timer _timer;
  bool counting = true;
  int timePassed; 

  void startTimer(int munites) {
    var timeInSeconds = munites * 60;
    const oneSec = const Duration(seconds: 1);
    timePassed = 0;
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (!counting) {
        return;
      }
      if (timeInSeconds < 1) {
        _time.sink.add("00:00");
        timer.cancel();
        _viewState.sink.add(EventState(Event.TIME_OUT));
      } else {
        _time.sink.add(convertTimeDuration(timeInSeconds));
        timeInSeconds = timeInSeconds - 1;
        ++timePassed;
      }
    });
  }

  void sendPageState(int index) {
    _pageState.sink.add("${++index}/${_license?.numberOfQuestion??0}");
  }

  void pauseTimer() {
    counting = false;
  }

  void resumeTimer() {
    counting = true;
  }

  void dispose() {
    _time.close();
    _viewState.close();
    _pageState.close();
    _timer.cancel();
  }
}
