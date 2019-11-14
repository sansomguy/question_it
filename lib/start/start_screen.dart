import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/create_question/screen.dart';
import 'package:question_it/questions/question_bloc.dart';
import 'package:question_it/start/start_button.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: StartButton(
                  buttonType: StartButtonType.Add,
                  onClick: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_) => CreateQuestionScreen()));
                  },
                ),
              ),
            ]),
          ),
        ),
      );
  }
}
