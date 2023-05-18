import 'package:do_vui_app/bloc/quiz_event.dart';
import 'package:do_vui_app/bloc/quiz_state.dart';
import 'package:do_vui_app/data/repository/quiz_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/quizModel.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepo;
  QuizBloc(this._quizRepo) : super(InitialQuiz()) {
    on<FectchQuiz>(
      fetchQuiz,
    );
    on<QuizSuccess>(_fetchSuccess);
  }
  Future<void> fetchQuiz(FectchQuiz event, Emitter<QuizState> emit) async {
    emit(LoadingQuiz());
    try {
      QuizRepository quizRepository = QuizRepository();
      QuizModel quizModel = await _quizRepo.getQuizs();
      emit(LoadedQuiz(quizModel: quizModel));
    } catch (e) {
      emit(FailedQuiz(message: e.toString()));
    }
  }

  Future<void> _fetchSuccess(QuizSuccess event, Emitter<QuizState> emit) async {
    try {
      emit(QuizSuccessed(quizIndex: event.index));
      emit(LoadedQuiz(quizModel: event.model));
    } catch (e) {
      emit(FailedQuiz(message: e.toString()));
    }
  }
}
