import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/questions/question_bloc.dart';
import 'package:question_it/questions/questions.dart';
import 'package:question_it/start/start_screen.dart';
import 'package:question_it/users/user_bloc.dart';
import 'package:question_it/users/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuestionsRepository>(
          builder: (_) => QuestionsRepository(),
        ),
        RepositoryProvider<UsersRepository>(
          builder: (_) => UsersRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionBloc>(
            builder: (context) => QuestionBloc(
              RepositoryProvider.of<QuestionsRepository>(context),
            ),
          ),
          BlocProvider<UserBloc>(
            builder: (context) => UserBloc(
              RepositoryProvider.of<UsersRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: StartScreen(),
        ),
      ),
    );
  }
}
