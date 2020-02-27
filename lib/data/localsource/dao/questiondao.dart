import 'package:drives_licence/model/zquestion.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class QuestionDao {
  final Database database = GetIt.I<Database>();

  Future<List<Zquestion>> questions(String questionFlat) async {
    final List<Map<String, dynamic>> maps = await database.query('zquestion',
        distinct: true, where: "$questionFlat = 1", limit: 20);

    return List.generate(maps.length, (i) {
      return Zquestion.fromJson(maps[i]);
    });
  }
}

String getQuestionFlat(String licenseName){
  String questionFlat = "ZINCLUDEA1";
  switch (licenseName) {
      case "A1":
        questionFlat = "ZINCLUDEA1";
        break;
      case "A2":
        questionFlat = "ZINCLUDEA2";
        break;
      case "A3":
      case "A4":
        questionFlat = "ZINCLUDEA3A4";
        break;
      case "B1":
        questionFlat = "ZINCLUDEB1";
        break;
      default:
        questionFlat = "1";
    }
    return questionFlat;
}
