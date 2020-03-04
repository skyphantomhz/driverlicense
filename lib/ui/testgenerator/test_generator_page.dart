import 'package:drives_licence/model/zhistory.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/testgenerator/test_generator_bloc.dart';
import 'package:drives_licence/util/time_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    testGeneratorBloc.getHistories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Làm bài kiểm tra ngẫu nhiên"),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Zhistory>>(
          stream: testGeneratorBloc.histories,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Zhistory> data = snapshot.data;
            if (data == null || data.length == 0) {
              return Container(
                child: Center(child: Text("Lịch sử trống")),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Zhistory history = data[index];
                    final leadIcon = history.result == 1
                        ? Icon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: Colors.green,
                          )
                        : Icon(
                            FontAwesomeIcons.solidTimesCircle,
                            color: Colors.red,
                          );
                    return Card(
                        child: ListTile(
                      leading: leadIcon,
                      title: Text(
                          "Result: ${history.numberTrue}/${history.numberTrue + history.numberOfFalse}"),
                      trailing: Text(
                          convertTimeDuration((history.time * 60).round())),
                    ));
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          testGeneratorBloc.generateQuestions();
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
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
