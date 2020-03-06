import 'package:drives_licence/model/ztest.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class TestDao {
  final Database database = GetIt.I<Database>();

  Future<List<Ztest>> tests(int licenseId) async {
    final List<Map<String, dynamic>> maps = await database.query('ztest', where: "CLASS_LICENSE = $licenseId");

    return List.generate(maps.length, (i) {
      return Ztest.fromJson(maps[i]);
    });
  }

  Future<int> insertTest(Ztest test) async {
    return database.insert(
      'ztest',
      test.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
