import 'package:drives_licence/data/localsource/dao/lightinfodao.dart';
import 'package:drives_licence/model/lightinfo.dart';
import 'package:get_it/get_it.dart';

class LightInfoService {
  LightInfoDao lightInfoDao = GetIt.I<LightInfoDao>();

  Future<List<LightInfo>> lightInfo() async {
    return lightInfoDao.lightInfo();
  }
}