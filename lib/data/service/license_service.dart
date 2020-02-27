import 'package:drives_licence/data/localsource/dao/licensedao.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:get_it/get_it.dart';

class LicenseService {
  LicenseDao licenseDao = GetIt.I<LicenseDao>();

  Future<List<Zlicense>> getLicenses() async {
    return licenseDao.licenses();
  }
}
