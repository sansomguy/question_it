import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/start/start_button.dart';
import 'package:question_it/start/start_screen_bloc.dart';

class StartScreen extends StatefulWidget {

  final StartScreenBloc bloc;

  StartScreen({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return _StartScreenState(bloc: this.bloc);
  }
}


class _StartScreenState extends State<StartScreen> {

  final StartScreenBloc bloc;

  _StartScreenState({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: StartButton(buttonType: StartButtonType.Search),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: StartButton(
                    buttonType: StartButtonType.Add,
                    onClick: () => bloc.createQuestion()
                )
            )
          ]),
        ));
  }
}