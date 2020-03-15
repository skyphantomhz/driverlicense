import 'package:drives_licence/data/localsource/dao/tipdao.dart';
import 'package:drives_licence/model/ztip.dart';
import 'package:drives_licence/model/ztipcategoty.dart';
import 'package:drives_licence/model/ztiptype.dart';
import 'package:get_it/get_it.dart';

class TipService {
  TipDao tipDao = GetIt.I<TipDao>();

  Future<List<ZtipType>> tipTypes() {
    return tipDao.tipTypes();
  }

  Future<List<ZtipCategory>> tipCategoties() {
    return tipDao.tipCategoties();
  }

  Future<List<Ztip>> tips() {
    return tipDao.tips();
  }
}
