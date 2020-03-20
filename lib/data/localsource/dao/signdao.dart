import 'package:drives_licence/model/zsign.dart';
import 'package:drives_licence/model/zsigncategory.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqlite_api.dart';

class SignDao {
  final Database database = GetIt.I<Database>();

  Future<List<ZsignCategory>> signCategories() async {
    final List<Map<String, dynamic>> maps =
        await database.query('zsigncategory');

    return generate(maps.length, (i) {
      return prepareSignCategories(maps[i]);
    });
  }

  Future<List<ZsignCategory>> generate(
      int length, Future<ZsignCategory> generator(int index),
      {bool growable = true}) async {
    List<ZsignCategory> result;
    if (growable) {
      result = <ZsignCategory>[]..length = length;
    } else {
      result = List<ZsignCategory>(length);
    }
    for (int i = 0; i < length; i++) {
      result[i] = await generator(i);
    }
    return result;
  }

  Future<ZsignCategory> prepareSignCategories(Map<String, dynamic> json) async {
    final signCategory = ZsignCategory.fromJson(json);
    signCategory.signs = await signs(signCategory.pk);
    return signCategory;
  }

  Future<List<Zsign>> signs(int categoryId) async {
    final List<Map<String, dynamic>> maps =
        await database.query('zsign', where: 'ZSIGNCATEGORY = $categoryId');

    return List.generate(maps.length, (i) {
      return Zsign.fromJson(maps[i]);
    });
  }
}
