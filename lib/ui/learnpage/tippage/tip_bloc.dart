import 'package:bloc_provider/bloc_provider.dart';
import 'package:drives_licence/data/service/tip_service.dart';
import 'package:drives_licence/model/ztip.dart';
import 'package:drives_licence/model/ztipcategoty.dart';
import 'package:drives_licence/model/ztiptype.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

class TipBloc extends Bloc {
  TipBloc() {
    getTipTypes();
    getTipCategories();
    getTips();
  }

  TipService _tipService = GetIt.I<TipService>();
  PublishSubject<List<ZtipType>> _tipTypes = PublishSubject();
  Stream<List<ZtipType>> get tipTypes => _tipTypes.stream;

  BehaviorSubject<List<ZtipCategory>> _theoryCategories = BehaviorSubject();
  Stream<List<ZtipCategory>> get theoryCategories => _theoryCategories.stream;

  BehaviorSubject<List<ZtipCategory>> _practiceCategories = BehaviorSubject();
  Stream<List<ZtipCategory>> get practiceCategories =>
      _practiceCategories.stream;

  List<Ztip> tips = List();

  void getTipTypes() async {
    final tipTypes = await _tipService.tipTypes();
    _tipTypes.add(tipTypes);
  }

  void getTipCategories() async {
    final tipCategories = await _tipService.tipCategoties();
    final theoryCategories =
        tipCategories.where((data) => data.tipType == 18).toList();
    final practiceCategories =
        tipCategories.where((data) => data.tipType == 19).toList();
    _theoryCategories.add(theoryCategories);
    _practiceCategories.add(practiceCategories);
  }

  void getTips() async {
    tips = await _tipService.tips();
  }

  String getTipsBy(int categoryId) {
    final tipsByCategory =
        this.tips.where((tip) => tip.tipCategory == categoryId).toList();
    tipsByCategory.sort((first, second) => first.index.compareTo(second.index));
    return tipsByCategory
        .map((tip) => "${tip.index}: ${tip.content}")
        .join("\n\n");
  }

  Stream<List<ZtipCategory>> getCategories(String key) {
    if (key == "[<'theory'>]") {
      return theoryCategories;
    } else {
      return practiceCategories;
    }
  }

  @override
  void dispose() {
    _tipTypes.close();
    _theoryCategories.close();
    _practiceCategories.close();
  }
}
