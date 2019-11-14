import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/create_question/screen.dart';
import 'package:question_it/questions/questions.dart';
import 'package:question_it/start/start_button.dart';
import 'package:question_it/settings/colors.dart' as app_colors;
import 'package:question_it/start/start_screen_bloc.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => StartScreenBloc(RepositoryProvider.of<QuestionsRepository>(context)),
      child: Container(
        color: app_colors.PrimaryB,
        child: SafeArea(
          child: Scaffold(
            body: Column(children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: StartButton(buttonType: StartButtonType.Search),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: BlocListener<StartScreenBloc, StartScreenState>(
                  listener: (context, state) {
                    if(state is QuestionCreationCompleted) {
                      Navigator.push(context,MaterialPageRoute(builder: (_) => CreateQuestionScreen()));
                    }
                  },
                  child: BlocBuilder<StartScreenBloc, StartScreenState>(
                    builder: (_, state) {
                      return StartButton(
                        buttonType: StartButtonType.Add,
                        onClick: () {
                          BlocProvider.of<StartScreenBloc>(_).add(CreateQuestionEvent());
                        },
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
