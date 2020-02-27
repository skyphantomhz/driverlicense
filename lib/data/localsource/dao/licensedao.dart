import 'package:drives_licence/model/zlicense.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class LicenseDao {
  final Database database = GetIt.I<Database>();

  Future<List<Zlicense>> licenses() async {
    final List<Map<String, dynamic>> maps = await database.query('zlicense');

    return List.generate(maps.length, (i) {
      return Zlicense.fromJson(maps[i]);
    });
  }
}
