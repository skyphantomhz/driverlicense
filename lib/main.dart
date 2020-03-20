import 'dart:async';
import 'dart:io';

import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/homepage/home_page.dart';
import 'package:drives_licence/ui/learnpage/learn_page.dart';
import 'package:drives_licence/ui/learnpage/questionpage/question_page.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_provider.dart';
import 'package:drives_licence/ui/licensespage/license_page.dart';
import 'package:drives_licence/ui/previewpage/preview_page.dart';
import 'package:drives_licence/ui/signpage/sign_page.dart';
import 'package:drives_licence/ui/splashscreen/splashpage.dart';
import 'package:drives_licence/ui/learnpage/testgenerator/test_generator_page.dart';
import 'package:drives_licence/ui/taplopage/taplo_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'di/appcomponent.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  return runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'great app', 'food', 'drink'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );
  BannerAd _bannerAd;

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-7567000157197488~3880950122");
    _bannerAd = createBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-7567000157197488/8322758014",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

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
        RouteName.LEARN: (context) => LearnPage(),
        RouteName.TIP: (context) => TipProvider(),
        RouteName.SIGN: (context) => SignPage(),
        RouteName.TAPLO: (context) => TaploPage(),
        RouteName.HOME: (context) => HomePage(
              bannerAd: _bannerAd,
            ),
      },
      onGenerateRoute: (settings) {
        if (settings?.name == RouteName.QUESTIONS) {
          return MaterialPageRoute(
              builder: (ctx) => QuestionPage(questions: settings.arguments));
        } else if (settings?.name == RouteName.PREVIEW) {
          return MaterialPageRoute(
              builder: (ctx) =>
                  PreviewPage(previewArguments: settings.arguments));
        }
      },
      builder: (context, widget) {
        var mediaQuery = MediaQuery.of(context);
        double paddingBottom = 50.0;
        double paddingRight = 0.0;
        if (mediaQuery.orientation == Orientation.landscape) {}
        return Container(
          color: Colors.white,
          child: new Padding(
              child: widget,
              padding:
                  EdgeInsets.only(bottom: paddingBottom, right: paddingRight)),
        );
      },
      navigatorObservers: [MyApp.observer],
    );
  }
}
