import 'package:drives_licence/data/service/sign_service.dart';
import 'package:drives_licence/model/zsigncategory.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

class SignBloc {
  SignService signService = GetIt.I<SignService>();

  BehaviorSubject<List<ZsignCategory>> _signCategories = BehaviorSubject();
  Stream<List<ZsignCategory>> get signCategories => _signCategories.stream;

  SignBloc() {
    getSigns();
  }

  void dispose() {
    _signCategories.close();
  }

  void getSigns() async {
    final signCategories = await signService.signCategories();
    _signCategories.add(signCategories);
  }
}
