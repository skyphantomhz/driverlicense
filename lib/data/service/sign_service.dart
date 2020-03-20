import 'package:drives_licence/data/localsource/dao/signdao.dart';
import 'package:drives_licence/model/zsigncategory.dart';
import 'package:get_it/get_it.dart';

class SignService {
  SignDao signDao = GetIt.I<SignDao>();

  Future<List<ZsignCategory>> signCategories() async {
    return signDao.signCategories();
  }
}