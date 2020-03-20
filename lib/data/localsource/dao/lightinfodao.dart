import 'package:drives_licence/model/lightinfo.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class LightInfoDao {
  final Database database = GetIt.I<Database>();

  Future<List<LightInfo>> lightInfo() async {
    final List<Map<String, dynamic>> maps = await database.query('lightinfo');

    return List.generate(maps.length, (i) {
      return LightInfo.fromJson(maps[i]);
    });
  }
}
