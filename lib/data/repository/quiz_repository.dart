import 'package:do_vui_app/data/provider/quiz_provider.dart';
import 'package:do_vui_app/data/quizModel.dart';

abstract class IQuizRepository {
  Future<QuizModel> getQuizs();
}

class QuizRepository extends IQuizRepository {
  final QuizProvider _quizProvider = QuizProvider();
  @override
  Future<QuizModel> getQuizs() {
    try {
      return _quizProvider.getQuizs();
    } catch (e) {
      throw e.toString();
    }
  }
}
