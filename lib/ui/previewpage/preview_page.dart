import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/previewpage/preview_bloc.dart';
import 'package:drives_licence/ui/learnpage/questionpage/question/question.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewPage extends StatefulWidget {
  final PreviewArguments previewArguments;
  PreviewPage({Key key, this.previewArguments}) : super(key: key);

  List<Zquestion> get questions => previewArguments.questions;

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  PreviewBloc previewBloc;

  @override
  void initState() {
    previewBloc = PreviewBloc(widget.previewArguments);
    super.initState();
  }

  @override
  void dispose() {
    previewBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Kết quả"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              StreamBuilder<bool>(
                stream: previewBloc.pass,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  final pass = snapshot?.data;
                  switch (pass) {
                    case true:
                      return Text("Đạt",
                          style: Theme.of(context)
                              .textTheme
                              .display2
                              .copyWith(color: Colors.green));
                      break;
                    case false:
                      return Text("Không Đạt",
                          style: Theme.of(context)
                              .textTheme
                              .display2
                              .copyWith(color: Colors.red));
                      break;
                    default:
                      return Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6),
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    Zquestion question = widget.questions[index];
                    var icon = Icon(
                      FontAwesomeIcons.solidTimesCircle,
                      color: Colors.red,
                    );
                    final isCorrectAnswer = question.isCorrect();
                    if (isCorrectAnswer == null) {
                      icon = Icon(
                        FontAwesomeIcons.exclamationTriangle,
                        color: Colors.yellow,
                      );
                    } else if (isCorrectAnswer) {
                      icon = Icon(
                        FontAwesomeIcons.solidCheckCircle,
                        color: Colors.green,
                      );
                    }
                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        _showQuestion(question);
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              (++index).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: icon,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuestion(Zquestion question) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
              child: Container(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        height: 800,
                        color: Colors.white,
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          children: <Widget>[
                            Question(question: question, enable: false),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PreviewArguments {
  final List<Zquestion> questions;
  final double timeInMinutes;

  PreviewArguments({this.questions, this.timeInMinutes});
}
