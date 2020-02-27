import 'package:drives_licence/data/service/license_service.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LicenseBloc {
  LicenseService lisenseService = GetIt.I<LicenseService>();
  
  LicenseBloc() {
    getLicenses();
  }

  PublishSubject<List<Zlicense>> _licenses = PublishSubject();
  Stream<List<Zlicense>> get licenses => _licenses.stream;

  void getLicenses() async {
    final licenses = await lisenseService.getLicenses();
    _licenses.sink.add(licenses);
  }

  void dispose() {
    _licenses.close();
  }
}
