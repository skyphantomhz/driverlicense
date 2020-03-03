import 'dart:convert';

import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc {
  JsonDecoder _decoder = GetIt.I<JsonDecoder>();
  Zlicense _license;

  HomeBloc() {
    _getTitle();
  }

  PublishSubject<String> _title = PublishSubject<String>();
  Stream<String> get title => _title.stream;

  void _getTitle() async {
    final preferrence = await SharedPreferences.getInstance();
    _license = Zlicense.fromJson(
        _decoder.convert(await preferrence.get(PreferrenceKey.LICENSE)));
    _title.sink.add("${_license.name} - ${_license.desc}");
  }

  void dispose() {
    _title.close();
  }
}
