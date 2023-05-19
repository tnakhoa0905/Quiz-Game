import 'package:do_vui_app/data/quizModel.dart';
import 'package:equatable/equatable.dart';

abstract class QuizEvent {}

class FectchQuiz extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class QuizSuccess extends QuizEvent {
  int index;
  QuizModel model;
  QuizSuccess({required this.index, required this.model});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class QuizCheckResult extends QuizEvent {
  String ans;
  String DapAn;
  QuizModel quizModel;
  String indexAns;
  QuizCheckResult(
      {required this.ans,
      required this.DapAn,
      required this.quizModel,
      required this.indexAns});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
