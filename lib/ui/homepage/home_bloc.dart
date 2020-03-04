import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/model/zlicense.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  Preferrence preferrence = GetIt.I<Preferrence>();
  Zlicense _license;

  HomeBloc() {
    _getTitle();
  }

  PublishSubject<String> _title = PublishSubject<String>();
  Stream<String> get title => _title.stream;

  void _getTitle() async {
    _license = await preferrence.license();
    _title.sink.add("${_license.name} - ${_license.desc}");
  }

  void dispose() {
    _title.close();
  }
}
