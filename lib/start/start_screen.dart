import 'package:flutter/material.dart';
import 'package:question_it/start/start_button.dart';
import 'package:question_it/start/start_screen_bloc.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class StartScreen extends StatefulWidget {
  final StartScreenBloc bloc;

  StartScreen({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  _StartScreenState();

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
                    onClick: () => this.widget.bloc.createQuestion(context)))
          ]),
        ),
      ),
    );
  }
}
