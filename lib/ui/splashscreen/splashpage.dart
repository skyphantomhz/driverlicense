import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatelessWidget {
  
  Preferrence _preferrence = GetIt.I<Preferrence>();
  Zlicense _license;

  SplashPage({Key key}) : super(key: key);

  void _initView() async {
    _license = await _preferrence.license();
  }

  void _intoApp(BuildContext context) {
    if (_license == null) {
      Navigator.pushReplacementNamed(context, RouteName.LICENSES);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.HOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initView();
    return Scaffold(
      body: FutureBuilder(
          future: GetIt.I.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Future.delayed(Duration(seconds: 2), () {
                _intoApp(context);
              });
              return Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              );
            } else {
              return Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
