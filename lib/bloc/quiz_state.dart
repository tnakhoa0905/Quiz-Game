import 'package:do_vui_app/data/quizModel.dart';
import 'package:equatable/equatable.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialQuiz extends QuizState {}

class LoadingQuiz extends QuizState {}

class LoadedQuiz extends QuizState {
  final QuizModel quizModel;

  LoadedQuiz({required this.quizModel});

  @override
  List<Object?> get props => [quizModel];
}

class FailedQuiz extends QuizState {
  final String message;

  FailedQuiz({required this.message});
  @override
  List<Object?> get props => [message];
}

class QuizSuccessed extends QuizState {
  final int quizIndex;

  QuizSuccessed({required this.quizIndex});

  @override
  List<Object?> get props => [quizIndex];
}

class QuizChecked extends QuizState {
  final bool ans;
  final String DapAn;
  QuizChecked({required this.ans, required this.DapAn});

  @override
  List<Object?> get props => [ans];
}
