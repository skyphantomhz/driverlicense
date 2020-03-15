import 'package:bloc_provider/bloc_provider.dart';
import 'package:drives_licence/model/ztiptype.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip/tip.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_bloc.dart';
import 'package:flutter/material.dart';

class TipPage extends StatefulWidget {
  TipPage({Key key}) : super(key: key);

  @override
  _TipPageState createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  TipBloc _tipBloc;

  @override
  void initState() {
    _tipBloc = BlocProvider.of<TipBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZtipType>>(
      stream: _tipBloc.tipTypes,
      builder: (context, snapshot) {
        final data = snapshot?.data;
        if (data == null) {
          return Container(
          );
        } else {
          List<Widget> _tabPages = List();
          _tabPages.add(TipView(key: Key("theory")));
          _tabPages.add(TipView(key: Key("practice")));
          List<Tab> _tabs = data
              .map((type) => Tab(
                    text: type.name,
                  ))
              .toList();
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
