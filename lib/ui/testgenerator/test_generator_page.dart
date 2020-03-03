import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/testgenerator/test_generator_bloc.dart';
import 'package:flutter/material.dart';

class TestGeneratorPage extends StatefulWidget {
  TestGeneratorPage({Key key}) : super(key: key);

  @override
  _TestGeneratorPageState createState() => _TestGeneratorPageState();
}

class _TestGeneratorPageState extends State<TestGeneratorPage> {
  TestGeneratorBloc testGeneratorBloc;

  @override
  void initState() {
    testGeneratorBloc = TestGeneratorBloc();
    setListener();
    super.initState();
  }

  @override
  void dispose() {
    testGeneratorBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RaisedButton(
              onPressed: () {
                testGeneratorBloc.generateQuestions();
              },
              child: Text(
                "Tạo bài thi",
                style: Theme.of(context).textTheme.button,
              )),
        ),
      ),
    );
  }

  void setListener() {
    testGeneratorBloc.questions.listen((data) {
      Navigator.of(context).pushNamed(RouteName.QUESTIONS, arguments: data);
    });
  }
}
