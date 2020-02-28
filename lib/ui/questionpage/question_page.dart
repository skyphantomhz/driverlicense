import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/questionpage/question/question.dart';
import 'package:drives_licence/ui/questionpage/question_bloc.dart';
import 'package:drives_licence/ui/questionpage/viewstate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key, this.license}) : super(key: key);

  final Zlicense license;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionBloc _questionBloc;
  PageController _controller;

  @override
  void initState() {
    _questionBloc = QuestionBloc(widget.license);
    _controller = PageController();
    _questionBloc.viewState.listen((state) {
      if (state is EventState && state.event == Event.TIME_OUT) {
        showTimeOutDialog();
      }
    });
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
          IconButton(
            icon: Icon(FontAwesomeIcons.paperPlane),
            onPressed: () {
              showSubmitDialog();
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Zquestion>>(
          stream: _questionBloc.questions,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Zquestion> data = snapshot.data;
            if (data == null) {
              return Container(
                alignment: Alignment.center,
                child: Text("Empty data"),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return Question(question: data[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
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
              Navigator.pushReplacementNamed(context, RouteName.PREVIEW);
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
              Navigator.pushReplacementNamed(context, RouteName.PREVIEW);
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
