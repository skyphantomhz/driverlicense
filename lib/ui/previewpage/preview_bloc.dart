import 'package:drives_licence/model/zquestion.dart';
import 'package:rxdart/rxdart.dart';

class PreviewBloc {
  PublishSubject<String> _correctAnswers = PublishSubject<String>();
  Stream<String> get correctAnswers => _correctAnswers.stream;

  PublishSubject<bool> _pass = PublishSubject<bool>();
  Stream<bool> get pass => _pass.stream;

  PreviewBloc(List<Zquestion> questions){
    _calculateCorrectAnswers(questions);
  }

  void _calculateCorrectAnswers(List<Zquestion> questions){
    var correctAnswers = 0;
    questions?.forEach((item) {
      if (item.isCorrect()) {
        ++correctAnswers;
      }
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      final message = "Your correct answers: $correctAnswers/20";
      _correctAnswers.sink.add(message);
      _pass.sink.add(correctAnswers>15);
    });
  }

  void dispose() {
    _correctAnswers.close();
    _pass.close();
  }
}
