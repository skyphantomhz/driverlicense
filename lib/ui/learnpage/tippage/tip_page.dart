import 'package:drives_licence/model/ztiptype.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip/tip.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipPage extends StatefulWidget {
  TipPage({Key key}) : super(key: key);

  @override
  _TipPageState createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  TipBloc _tipBloc;

  @override
  void initState() {
    _tipBloc = TipBloc();
    super.initState();
  }

  @override
  void dispose() {
    _tipBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZtipType>>(
      stream: _tipBloc.tipTypes,
      builder: (context, snapshot) {
        final data = snapshot?.data;
        if (data == null) {
          return Container(
            color: Colors.purple,
          );
        } else {
          List<Widget> _tabPages = data.map((type) => TipView(
                category: _tipBloc.getTipCategory(type.pk),
              )).toList();
          List<Tab> _tabs = data.map((type) => Tab(
                text: type.name,
              )).toList();
          return DefaultTabController(
            length: data.length,
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Mẹo thi kết quả cao"),
                  bottom: TabBar(tabs: _tabs),
                ),
                body: SafeArea(
                  child: TabBarView(
                    children: _tabPages,
                  ),
                )),
          );
        }
      },
    );
  }
}
