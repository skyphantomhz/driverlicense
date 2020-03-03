import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/homepage/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

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
    return Scaffold(
      body: SafeArea(
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? 2
                        : 3),
            children: <Widget>[
              _buildItem("Thi Thử", FontAwesomeIcons.penFancy, () {
                Navigator.of(context).pushNamed(RouteName.TEST_GENERATOR);
              }),
              _buildItem("Học", FontAwesomeIcons.bookOpen, () {
                Navigator.of(context).pushNamed(RouteName.TEST_GENERATOR);
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
          padding: EdgeInsets.all(8),
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
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white))
              ]),
        ),
      ),
    );
  }
}
