import 'dart:async';
import 'dart:convert';

import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferrence {
  final _decoder = GetIt.I<JsonDecoder>();
  final _encoder = GetIt.I<JsonEncoder>();

  Future<Zlicense> license() async {
    final completer = Completer<Zlicense>();
    final preferrence = await SharedPreferences.getInstance();
    String licenseStr = await preferrence.get(PreferrenceKey.LICENSE);
    if (licenseStr?.isNotEmpty ?? false) {
      final _license = Zlicense.fromJson(_decoder.convert(licenseStr));
      completer.complete(_license);
    } else {
      completer.complete(null);
    }
    return completer.future;
  }

  void setLicense(Zlicense license) async {
    final preferrence = await SharedPreferences.getInstance();
    preferrence.setString(
        PreferrenceKey.LICENSE, _encoder.convert(license.toJson()));
  }
}
