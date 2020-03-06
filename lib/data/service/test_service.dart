import 'package:drives_licence/data/localsource/dao/testdao.dart';
import 'package:drives_licence/data/localsource/dao/testquestdao.dart';
import 'package:drives_licence/data/localsource/preferrence.dart';
import 'package:drives_licence/model/zquestion.dart';
import 'package:drives_licence/model/ztest.dart';
import 'package:drives_licence/model/ztestquest.dart';
import 'package:get_it/get_it.dart';

class TestService {
  TestDao testDao = GetIt.I<TestDao>();
  TestQuestDao testQuestDao = GetIt.I<TestQuestDao>();
  Preferrence preferrence = GetIt.I<Preferrence>();

  Future<List<Ztest>> tests() async {
    final license = await preferrence.license();
    return testDao.tests(license.pk);
  }

  void insertTest(
      List<Zquestion> questions, int testName, int passedTime) async {
    final license = await preferrence.license();
    final currentTime = DateTime.now().millisecond;
    final test = Ztest(
        testName: testName,
        currentQuest: 0,
        licenseId: license.pk,
        currentTime: passedTime,
        timeHis: currentTime,
        totalSuccess: license.numberOfQuestion,
        isFinish: 1);
    final testId = await testDao.insertTest(test);
    _insertTestQuest(questions, testId);
  }

  void _insertTestQuest(List<Zquestion> questions, int testId) {
    questions.forEach((question) {
      final testQuest = ZtestQuest(
          testId: testId,
          questionId: question.pk,
          answer: question.answerSubmit(),
          history: "",
          isCorrect: question.isCorrect());
      testQuestDao.insertTestQuest(testQuest);
    });
  }
}
