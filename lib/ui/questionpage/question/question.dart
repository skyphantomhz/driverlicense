import 'package:drives_licence/model/zquestion.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final Zquestion question;
  Set<int> optionSelected = Set<int>();

  Question({@required this.question});

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
    return Card(
      child: Container(
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
              children: _buildOptions(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImageQuestion(String image) {
    if (image?.isEmpty ?? true) {
      return Container();
    } else {
      final fileNameConverted = image.replaceFirst("jpg", "webp");
      return Expanded(
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

  Widget _buildOption(String option, int indexed) {
    return InkWell(
      onTap: () {
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
          style: Theme.of(context).textTheme.body1,
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
    return widget.optionSelected.contains(indexed);
  }

  void selectOption(int indexed) {
    widget.optionSelected.add(indexed);
  }

  void unselectOption(int indexed) {
    widget.optionSelected.remove(indexed);
  }
}
