import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

import 'buttons.dart';

typedef OnTypeSet(QuestionType type);

class CreateQuestionHeader extends StatelessWidget {

  final OnTypeSet onTypeSet;

  CreateQuestionHeader({Key key, this.onTypeSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: kToolbarHeight),
        decoration: BoxDecoration(
            color: app_colors.PrimaryA,
            border: Border(
                bottom: BorderSide(
                    color: app_colors.PrimaryADarkened,
                    width: 1,
                    style: BorderStyle.solid))),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: QuestionTypeButton(questionType: QuestionType.Letters, onPressed: onTypeSet),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: QuestionTypeButton(questionType: QuestionType.Number, onPressed: onTypeSet),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: QuestionTypeButton(questionType: QuestionType.Fibonacci, onPressed: onTypeSet),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: QuestionTypeButton(questionType: QuestionType.Emoji, onPressed: onTypeSet)
              ),
            ]));
  }
}
