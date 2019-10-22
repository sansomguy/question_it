import 'package:flutter/material.dart';
import 'package:question_it/start/start_button.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            child: StartButton(buttonType: StartButtonType.Add)),
      ]),
    ));
  }
}
