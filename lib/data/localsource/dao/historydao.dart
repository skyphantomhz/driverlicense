import 'package:drives_licence/model/zhistory.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDao {
  final Database database = GetIt.I<Database>();

  Future<List<Zhistory>> histories(int licenseId) async {
    final List<Map<String, dynamic>> maps = await database.query('zhistory', where: 'ZLICENSE = $licenseId');

    return List.generate(maps.length, (i) {
      return Zhistory.fromJson(maps[i]);
    });
  }

  void insertHistory(Zhistory history) async {
    await database.insert(
      'zhistory',
      history.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
