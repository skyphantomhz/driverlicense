import 'package:drives_licence/model/zquestion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewPage extends StatefulWidget {
  final List<Zquestion> questions;
  PreviewPage({Key key, this.questions}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Kết quả"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.share),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }
}
