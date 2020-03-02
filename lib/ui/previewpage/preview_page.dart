import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/previewpage/preview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewPage extends StatefulWidget {
  final List<Zquestion> questions;
  PreviewPage({Key key, this.questions}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {

  PreviewBloc previewBloc;

  @override
  void initState() {
    previewBloc = PreviewBloc()..calculateCorrectAnswers(widget.questions);
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
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.share),
            onPressed: () {
              previewBloc.calculateCorrectAnswers(widget.questions);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder<String>(
            stream: previewBloc.correctAnswers,
            initialData: 'Empty data',
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              final message = snapshot?.data ?? "NULL";
              return Text(message);
            }
          ),
        ),
      ),
    );
  }
}
