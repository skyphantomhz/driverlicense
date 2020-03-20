import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/homepage/home_bloc.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final BannerAd bannerAd;
  HomePage({Key key, this.bannerAd}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      widget.bannerAd
        ..load()
        ..show();
    }
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: _homeBloc.title,
          builder: (context, snapshot) {
            return Text(snapshot?.data??"");
          }
        ),
        actions: <Widget>[
        IconButton(icon: Icon(FontAwesomeIcons.cog), onPressed: (){
          Navigator.of(context).pushNamed(RouteName.LICENSES);
        },)
      ],),
      body: SafeArea(
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? 2
                        : 3),
            children: <Widget>[
              _buildItem("Thi Sát Hạch", FontAwesomeIcons.penFancy, () {
                Navigator.of(context).pushNamed(RouteName.TEST_GENERATOR);
              }),
              _buildItem("Học Lý Thuyết", FontAwesomeIcons.bookOpen, () {
                Navigator.of(context).pushNamed(RouteName.LEARN);
              }),
              _buildItem("Biển Báo Đường Bộ", FontAwesomeIcons.directions, () {
                Navigator.of(context).pushNamed(RouteName.SIGN);
              }),
            ]),
      ),
    );
  }

  Widget _buildItem(String title, IconData icon, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Icon(
                      icon,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(title,
                  textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white)),
                )
              ]),
        ),
      ),
    );
  }
}
