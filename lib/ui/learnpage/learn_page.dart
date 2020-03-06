import 'package:drives_licence/ui/learnpage/learn_bloc.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  LearnPage({Key key}) : super(key: key);

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  LearnBloc _learnBloc;

  @override
  void initState() {
    _learnBloc = LearnBloc();
    super.initState();
  }

  @override
  void dispose() {
    _learnBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Học Lý Thuyết"),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Card(
            child: ListTile(title: Text("Mẹo thi"),)
          ),
          Card(
            child: ListTile(title: Text("Những câu hỏi hay sai"),)
          ),
          Card(
            child: ListTile(title: Text("Những câu hỏi chưa bao giờ trả lời"),)
          ),
        ],),
      ),
    );
  }
}
