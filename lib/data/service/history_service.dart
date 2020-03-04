import 'package:drives_licence/data/localsource/dao/historydao.dart';
import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/model/zhistory.dart';
import 'package:get_it/get_it.dart';

class HistoryService{
  HistoryDao historyDao = GetIt.I<HistoryDao>();
  Preferrence preferrence = GetIt.I<Preferrence>();

  Future<List<Zhistory>> histories() async {
    final license = await preferrence.license();
    return historyDao.histories(license.pk);
  }

  void insertHistory(Zhistory history) async {
    historyDao.insertHistory(history);
  }
}