import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/previewpage/preview_page.dart';
import 'package:drives_licence/ui/learnpage/questionpage/question/question.dart';
import 'package:drives_licence/ui/learnpage/questionpage/question_bloc.dart';
import 'package:drives_licence/ui/learnpage/questionpage/viewstate.dart';
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
          IconButton(
            icon: Icon(FontAwesomeIcons.paperPlane),
            onPressed: () {
              showSubmitDialog();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Container(
            // height: MediaQuery.of(context).size.height * 0.7,
            // child:
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
                  return Card(
                      child: Question(question: widget.questions[index]));
                },
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      _controller?.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: StreamBuilder(
                        stream: _questionBloc.pageState,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(
                            snapshot?.data ?? "N/A",
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      _controller?.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn);
                    },
                    icon: Icon(
                      Icons.chevron_right,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                  arguments: PreviewArguments(
                      questions: widget.questions,
                      timeInMinutes: _questionBloc.timePassed / 60));
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
                  arguments: PreviewArguments(
                      questions: widget.questions,
                      timeInMinutes: _questionBloc.timePassed / 60));
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
