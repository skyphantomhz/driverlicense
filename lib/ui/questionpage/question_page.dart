import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/previewpage/preview_page.dart';
import 'package:drives_licence/ui/questionpage/question/question.dart';
import 'package:drives_licence/ui/questionpage/question_bloc.dart';
import 'package:drives_licence/ui/questionpage/viewstate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key, this.questions}) : super(key: key);

  final List<Zquestion> questions;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionBloc _questionBloc;
  PageController _controller;

  @override
  void initState() {
    _questionBloc = QuestionBloc();
    _controller = PageController();
    _questionBloc.viewState.listen((state) {
      if (state is EventState && state.event == Event.TIME_OUT) {
        showTimeOutDialog();
      }
    });
    _questionBloc.sendPageState(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: StreamBuilder<String>(
            stream: _questionBloc.time,
            builder: (context, snapshot) {
              return Text(
                snapshot?.data?.toString() ?? "00:00",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              );
            }),
        centerTitle: true,
        actions: <Widget>[
          Center(
            child: StreamBuilder(
              stream: _questionBloc.pageState,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  snapshot?.data ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.paperPlane),
            onPressed: () {
              showSubmitDialog();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Row(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.questions.length,
                  controller: _controller,
                  onPageChanged: (index) {
                    _questionBloc.sendPageState(index);
                    print(
                        "The answer at $index is ${widget.questions[index].answers}");
                  },
                  itemBuilder: (context, index) {
                    return Question(question: widget.questions[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSubmitDialog() async {
    _questionBloc.pauseTimer();
    await showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        title: Text('Xác Nhận'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Bạn có chắc muốn nộp bài.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, RouteName.PREVIEW,
                  arguments:
                      PreviewArguments(questions: widget.questions,  timeInMinutes: _questionBloc.timePassed/60));
            },
            child: Text(
              'Nộp bài',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
    _questionBloc.resumeTimer();
  }

  void showTimeOutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text('Hết thời gian'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Đã hết thời gian làm bài, vui lòng nộp bài'),
            ],
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, RouteName.PREVIEW,
                  arguments:
                      PreviewArguments(questions: widget.questions, timeInMinutes: _questionBloc.timePassed/60));
            },
            child: Text(
              'Nộp bài',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questionBloc.dispose();
    super.dispose();
  }
}
