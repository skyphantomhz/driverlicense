import 'package:drives_licence/model/zquestion.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final Zquestion question;
  final enable;

  Question({@required this.question, this.enable = true}) {
    if (question.answerSubmited == null) {
      question.answerSubmited = Set();
    }
  }

  Set<int> get answerSubmitted => question.answerSubmited;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  get styleSelected => Theme.of(context)
      .textTheme
      .body2
      .copyWith(color: Theme.of(context).colorScheme.onSurface);
  get styleNormal => Theme.of(context)
      .textTheme
      .body2
      .copyWith(color: Theme.of(context).colorScheme.surface);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.question.questionContent,
              style: Theme.of(context).textTheme.body2,
            ),
          ),
          buildImageQuestion(widget.question.image),
          Column(
            children: _buildOptions()..add(_buildHintView()),
          ),
        ],
      ),
    );
  }

  Widget _buildHintView() {
    if (widget.enable) {
      return SizedBox(
        width: 10,
      );
    } else {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
            color: Colors.green[100],
            padding: EdgeInsets.all(8),
            child: Text(
              widget.question.answerDesc,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.white),
            )),
      );
    }
  }

  Widget buildImageQuestion(String image) {
    if (image?.isEmpty ?? true) {
      return Container();
    } else {
      final fileNameConverted = image.replaceFirst("jpg", "webp");
      return Container(
        child: Image.asset("assets/imageapp/$fileNameConverted"),
      );
    }
  }

  List<Widget> _buildOptions() {
    return List.generate(4, (index) {
      final option = widget.question.getOption(index);
      if (option?.isEmpty ?? true) {
        return Container();
      } else {
        return _buildOption(option, ++index);
      }
    });
  }

  TextStyle answerStatusAt(int indexed) {
    if (widget.enable) {
      return Theme.of(context).textTheme.body1;
    }
    bool selected = widget.question.answerSubmited.contains(indexed);
    bool isCorrectAnswer = widget.question.answers.contains("$indexed");
    if (isCorrectAnswer)
      return Theme.of(context).textTheme.body1.copyWith(color: Colors.green);
    else if (selected)
      return Theme.of(context).textTheme.body1.copyWith(color: Colors.red);
    else
      return Theme.of(context).textTheme.body1;
  }

  Widget _buildOption(String option, int indexed) {
    return InkWell(
      onTap: () {
        if (!widget.enable) return;
        setState(() {
          if (isOptionSelected(indexed)) {
            unselectOption(indexed);
          } else {
            selectOption(indexed);
          }
        });
      },
      child: ListTile(
        leading: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Text((indexed).toString(), style: getTextStyle(indexed)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              color: getBackground(indexed)),
        ),
        title: Text(
          option,
          style: answerStatusAt(indexed),
        ),
      ),
    );
  }

  Color getBackground(int indexed) {
    if (isOptionSelected(indexed)) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.background;
    }
  }

  TextStyle getTextStyle(int indexed) {
    if (isOptionSelected(indexed)) {
      return styleSelected;
    } else {
      return styleNormal;
    }
  }

  bool isOptionSelected(int indexed) {
    return widget.answerSubmitted.contains(indexed);
  }

  void selectOption(int indexed) {
    widget.answerSubmitted.add(indexed);
  }

  void unselectOption(int indexed) {
    widget.answerSubmitted.remove(indexed);
  }
}
