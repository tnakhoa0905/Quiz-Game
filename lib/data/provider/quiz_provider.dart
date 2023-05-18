import 'dart:convert';

import 'package:do_vui_app/data/quizModel.dart';
import 'package:do_vui_app/data/repository/quiz_repository.dart';
import 'package:http/http.dart' as http;

class QuizProvider extends IQuizRepository {
  String url = "https://pdteam-quiz.herokuapp.com/questions?limit=10";
  @override
  Future<QuizModel> getQuizs() async {
    final response = await http.get(Uri.parse(url));
    print(response);
    print("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-");
    if (response.statusCode == 200) {
      return QuizModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to loading');
    }
  }
}
