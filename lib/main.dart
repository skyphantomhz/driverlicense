import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/homepage/home_page.dart';
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
        RouteName.HOME: (context) => HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings?.name == RouteName.QUESTIONS) {
          return MaterialPageRoute(
              builder: (ctx) => QuestionPage(questions: settings.arguments));
        } else if (settings?.name == RouteName.PREVIEW) {
          return MaterialPageRoute(
              builder: (ctx) => PreviewPage(previewArguments: settings.arguments));
        }
      },
    );
  }
}
