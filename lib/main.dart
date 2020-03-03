import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/licensespage/license_page.dart';
import 'package:drives_licence/ui/previewpage/preview_page.dart';
import 'package:drives_licence/ui/questionpage/question_page.dart';
import 'package:drives_licence/ui/splashpage.dart';
import 'package:drives_licence/ui/testgenerator/test_generator_bloc.dart';
import 'package:drives_licence/ui/testgenerator/test_generator_page.dart';
import 'package:flutter/material.dart';

import 'di/appcomponent.dart';

void main() {
  setupLocator();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.SPLASH,
      routes: {
        RouteName.SPLASH: (context) => SplashPage(),
        RouteName.LICENSES: (context) => LicensesPage(),
        RouteName.TEST_GENERATOR: (context) => TestGeneratorPage(),
        RouteName.HOME: (context) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
      },
      onGenerateRoute: (settings) {
        if (settings?.name == RouteName.QUESTIONS) {
          return MaterialPageRoute(
              builder: (ctx) => QuestionPage(questions: settings.arguments));
        } else if (settings?.name == RouteName.PREVIEW) {
          return MaterialPageRoute(
              builder: (ctx) => PreviewPage(questions: settings.arguments));
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
