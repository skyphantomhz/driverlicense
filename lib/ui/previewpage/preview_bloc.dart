import 'package:drives_licence/model/zquestion.dart';
import 'package:rxdart/rxdart.dart';

class PreviewBloc {
  PublishSubject<String> _correctAnswers = PublishSubject<String>();
  Stream<String> get correctAnswers => _correctAnswers.stream;

  void calculateCorrectAnswers(List<Zquestion> questions){
    var correctAnswers = 0;
    questions?.forEach((item) {
      if (item.isCorrect()) {
        ++correctAnswers;
      }
    });
    Future.delayed(Duration(milliseconds: 500), () {
      final message = "Your correct answers: $correctAnswers/20";
      _correctAnswers.sink.add(message);
    });
  }

  void dispose() {
    _correctAnswers.close();
  }
}
