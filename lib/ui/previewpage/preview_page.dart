import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/ui/previewpage/preview_bloc.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.share),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder<bool>(
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
              }),
        ),
      ),
    );
  }
}

class PreviewArguments {
  final List<Zquestion> questions;
  final double timeInMinutes;

  PreviewArguments({this.questions, this.timeInMinutes});
}
