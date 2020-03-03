import 'dart:convert';

import 'package:drives_licence/data/service/license_service.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicenseBloc {
  LicenseService lisenseService = GetIt.I<LicenseService>();
  final _encoder = GetIt.I<JsonEncoder>();
  
  LicenseBloc() {
    getLicenses();
  }

  PublishSubject<List<Zlicense>> _licenses = PublishSubject();
  Stream<List<Zlicense>> get licenses => _licenses.stream;

  PublishSubject<Event> _eventState = PublishSubject();
  Stream<Event> get eventState => _eventState.stream;

  void getLicenses() async {
    final licenses = await lisenseService.getLicenses();
    _licenses.sink.add(licenses);
  }

  void saveSelectedLicense(Zlicense license) async {
    _eventState.sink.add(Event.LOADING);
    final preferrence = await SharedPreferences.getInstance();
    preferrence.setString(PreferrenceKey.LICENSE, _encoder.convert(license.toJson()));
    _eventState.sink.add(Event.TEST_GENERATOR);
  }

  void dispose() {
    _licenses.close();
    _eventState.close();
  }
}

enum Event{
    LOADING,
    TEST_GENERATOR
  }
