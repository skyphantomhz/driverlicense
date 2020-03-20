import 'package:drives_licence/model/ztip.dart';
import 'package:drives_licence/model/ztipcategoty.dart';
import 'package:drives_licence/model/ztiptype.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqlite_api.dart';

class TipDao {
  final Database database = GetIt.I<Database>();

  Future<List<ZtipType>> tipTypes() async {
    final List<Map<String, dynamic>> maps = await database.query('ztiptype');

    return List.generate(maps.length, (i) {
      return ZtipType.fromJson(maps[i]);
    });
  }

  Future<List<ZtipCategory>> tipCategoties() async {
    final List<Map<String, dynamic>> maps = await database.query('ztipcategory');

    return List.generate(maps.length, (i) {
      return ZtipCategory.fromJson(maps[i]);
    });
  }

  Future<List<Ztip>> tips() async {
    final List<Map<String, dynamic>> maps = await database.query('ztip');

    return List.generate(maps.length, (i) {
      return Ztip.fromJson(maps[i]);
    });
  }
}