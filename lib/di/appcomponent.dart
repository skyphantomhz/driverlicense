import 'dart:convert';

import 'package:drives_licence/data/localsource/appdatabase.dart';
import 'package:drives_licence/data/localsource/dao/historydao.dart';
import 'package:drives_licence/data/localsource/dao/licensedao.dart';
import 'package:drives_licence/data/localsource/dao/questiondao.dart';
import 'package:drives_licence/data/localsource/dao/testdao.dart';
import 'package:drives_licence/data/localsource/dao/testquestdao.dart';
import 'package:drives_licence/data/localsource/dao/tipdao.dart';
import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/data/service/history_service.dart';
import 'package:drives_licence/data/service/license_service.dart';
import 'package:drives_licence/data/service/question_service.dart';
import 'package:drives_licence/data/service/test_service.dart';
import 'package:drives_licence/data/service/tip_service.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingletonAsync<Database>(() => getDatabase());
  getIt.registerLazySingleton<JsonDecoder>(() => JsonDecoder());
  getIt.registerLazySingleton<JsonEncoder>(() => JsonEncoder());
  getIt.registerLazySingleton<Preferrence>(() => Preferrence());

  getIt.registerLazySingleton<LicenseDao>(() => LicenseDao());
  getIt.registerLazySingleton<QuestionDao>(() => QuestionDao());
  getIt.registerLazySingleton<HistoryDao>(() => HistoryDao());
  getIt.registerLazySingleton<TestDao>(() => TestDao());
  getIt.registerLazySingleton<TestQuestDao>(() => TestQuestDao());
  getIt.registerLazySingleton<TipDao>(() => TipDao());

  getIt.registerLazySingleton<LicenseService>(() => LicenseService());
  getIt.registerLazySingleton<QuestionService>(() => QuestionService());
  getIt.registerLazySingleton<HistoryService>(() => HistoryService());
  getIt.registerLazySingleton<TestService>(() => TestService());
  getIt.registerLazySingleton<TipService>(() => TipService());
}
