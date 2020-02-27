import 'package:drives_licence/ui/global.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: GetIt.I.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushReplacementNamed(context, RouteName.LICENSES);
              });
              return Container(
                decoration: BoxDecoration(color: Colors.yellow),
              );
            } else {
              return Container(
                decoration: BoxDecoration(color: Colors.yellow),
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
