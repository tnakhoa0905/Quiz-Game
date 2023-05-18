import 'package:do_vui_app/bloc/quiz_bloc.dart';
import 'package:do_vui_app/bloc/quiz_event.dart';
import 'package:do_vui_app/bloc/quiz_state.dart';
import 'package:do_vui_app/data/repository/quiz_repository.dart';

import 'package:do_vui_app/presentation/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => QuizRepository(),
      child: BlocProvider<QuizBloc>(
        create: (context) =>
            QuizBloc(context.read<QuizRepository>())..fetchQuiz,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
