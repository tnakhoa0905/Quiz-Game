import 'dart:math';

import 'package:do_vui_app/bloc/quiz_event.dart';
import 'package:do_vui_app/bloc/quiz_state.dart';
import 'package:do_vui_app/data/repository/quiz_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/quizModel.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepo;
  QuizBloc(this._quizRepo) : super(LoadingQuiz()) {
    on<QuizSuccess>(((event, emit) => _fetchSuccess(event, emit)));
    on<QuizCheckResult>(((event, emit) => _checkSuccess(event, emit)));
  }

  Future<void> fetchQuiz() async {
    // emit(LoadingQuiz());
    try {
      QuizRepository quizRepository = QuizRepository();
      QuizModel quizModel = await _quizRepo.getQuizs();
      swapAns(quizModel, 0);
      emit(LoadedQuiz(quizModel: quizModel));
    } catch (e) {
      emit(FailedQuiz(message: e.toString()));
    }
  }

  void _fetchSuccess(QuizSuccess event, Emitter<QuizState> emit) {
    try {
      emit(QuizSuccessed(quizIndex: event.index));
      swapAns(event.model, event.index);
      emit(LoadedQuiz(quizModel: event.model));
    } catch (e) {
      emit(FailedQuiz(message: e.toString()));
    }
  }

  void _checkSuccess(QuizCheckResult event, Emitter<QuizState> emit) {
    if (event.ans.contains(event.DapAn)) {
      emit(QuizChecked(ans: true, DapAn: event.indexAns));
    } else {
      emit(QuizChecked(ans: false, DapAn: event.indexAns));
    }
    emit(LoadedQuiz(quizModel: event.quizModel));
  }

  void swapAns(QuizModel quiz, int indexLists) {
    int random = Random().nextInt(3);
    List<String> ans = [
      quiz.data[indexLists].a,
      quiz.data[indexLists].b,
      quiz.data[indexLists].c,
      quiz.data[indexLists].d
    ];
    ans.shuffle();

    quiz.data[indexLists].a = ans[0];
    quiz.data[indexLists].b = ans[1];
    quiz.data[indexLists].c = ans[2];
    quiz.data[indexLists].d = ans[3];
  }
}
