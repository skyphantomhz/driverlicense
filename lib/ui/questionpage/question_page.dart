import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/questionpage/question_bloc.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key, this.licenseName}) : super(key: key);

  final String licenseName;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionBloc _questionBloc;

  @override
  void initState() {
    _questionBloc = QuestionBloc(widget.licenseName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Zquestion>>(
        stream: _questionBloc.questions,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Zquestion> data = snapshot.data;
          if (data == null) {
            return Container(
              alignment: Alignment.center,
              child: Text("Empty data"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("${item.questionType}");
                    },
                    child: ListTile(
                        leading: Container(
                          width: 30,
                          alignment: Alignment.centerLeft,
                          child: Text(item.questionType.toString(),
                              style: Theme.of(context).textTheme.body2),
                        ),
                        title: Text(item.questionContent,
                            style: Theme.of(context).textTheme.body1)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _questionBloc.dispose();
    super.dispose();
  }
}
