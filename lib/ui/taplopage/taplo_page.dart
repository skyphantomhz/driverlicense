import 'package:drives_licence/model/lightinfo.dart';
import 'package:drives_licence/ui/taplopage/taplo_bloc.dart';
import 'package:flutter/material.dart';

class TaploPage extends StatefulWidget {
  TaploPage({Key key}) : super(key: key);

  @override
  _TaploPageState createState() => _TaploPageState();
}

class _TaploPageState extends State<TaploPage> {
  TaploBloc _taploBloc;

  @override
  void initState() {
    _taploBloc = TaploBloc();
    super.initState();
  }

  @override
  void dispose() {
    _taploBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ý nghĩ của đèn hiệu trên taplo"),
        leading: BackButton(),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: StreamBuilder<List<LightInfo>>(
              stream: _taploBloc.lightInfos,
              builder: (context, snapshot) {
                final lights = snapshot.data;
                if (lights?.isEmpty ?? true) {
                  return Container(
                    color: Colors.black,
                  );
                } else {
                  return GridView.builder(
                      itemCount: lights.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        final item = lights[index];
                        return InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/icon_taplo/${item.id}.jpeg",
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
