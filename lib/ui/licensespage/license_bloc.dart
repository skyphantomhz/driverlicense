import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/data/service/license_service.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LicenseBloc {
  LicenseService lisenseService = GetIt.I<LicenseService>();
  Preferrence preferrence = GetIt.I<Preferrence>();
  
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
    preferrence.setLicense(license);
    _eventState.sink.add(Event.HOME);
  }

  void dispose() {
    _licenses.close();
    _eventState.close();
  }
}

enum Event{
    LOADING,
    HOME
  }
