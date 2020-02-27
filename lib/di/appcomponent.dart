import 'dart:convert';

import 'package:drives_licence/data/localsource/appdatabase.dart';
import 'package:drives_licence/data/localsource/dao/licensedao.dart';
import 'package:drives_licence/data/localsource/dao/questiondao.dart';
import 'package:drives_licence/data/service/license_service.dart';
import 'package:drives_licence/data/service/question_service.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingletonAsync<Database>(() => getDatabase());
  getIt.registerLazySingleton<JsonDecoder>(() => JsonDecoder());

  getIt.registerLazySingleton<LicenseDao>(() => LicenseDao());
  getIt.registerLazySingleton<QuestionDao>(() => QuestionDao());

  getIt.registerLazySingleton<LicenseService>(() => LicenseService());
  getIt.registerLazySingleton<QuestionService>(() => QuestionService());
}
