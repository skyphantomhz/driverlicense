import 'package:drives_licence/data/service/tip_service.dart';
import 'package:drives_licence/model/ztiptype.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

class TipBloc {
  TipBloc() {
    getTipTypes();
  }

  TipService _tipService = GetIt.I<TipService>();
  PublishSubject<List<ZtipType>> _tipTypes = PublishSubject();
  Stream<List<ZtipType>> get tipTypes => _tipTypes.stream;

  void getTipTypes() async {
    final tipTypes = await _tipService.tipTypes();
    _tipTypes.add(tipTypes);
  }

  void dispose() {
    _tipTypes.close();
  }

  getTipCategory(int pk) {
    
  }
}
