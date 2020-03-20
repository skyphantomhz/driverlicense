import 'package:drives_licence/model/ztestquest.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class TestQuestDao {
  final Database database = GetIt.I<Database>();

  Future<List<ZtestQuest>> testQuestions(int licenseId) async {
    final List<Map<String, dynamic>> maps = await database.query('ztest', where: "CLASS_LICENSE = $licenseId");
    return List.generate(maps.length, (i) {
      return ZtestQuest.fromJson(maps[i]);
    });
  }

  void insertTestQuest(ZtestQuest testQuest) async {
    await database.insert(
      'ztestquest',
      testQuest.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}