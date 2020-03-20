import 'package:drives_licence/data/service/light_info_service.dart';
import 'package:drives_licence/model/lightinfo.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

class TaploBloc {
  LightInfoService _lightInfoService = GetIt.I<LightInfoService>();

  BehaviorSubject<List<LightInfo>> _lightInfos = BehaviorSubject();
  Stream<List<LightInfo>> get lightInfos => _lightInfos.stream;

  TaploBloc() {
    getLightInfo();
  }

  void dispose() {
    _lightInfos.close();
  }

  void getLightInfo() async {
    final lightInfo = await _lightInfoService.lightInfo();
    _lightInfos.add(lightInfo);
  }
}
