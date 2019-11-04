import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/question_type_icon.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/colors.dart' as app_colors;


typedef OnPressed(QuestionType type);


class QuestionTypeButton extends StatefulWidget {

  final OnPressed onPressed;
  QuestionType questionType;
  QuestionTypeButton({Key key, this.questionType, this.onPressed}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionTypeButtonState(questionType, this.onPressed);
  }
}

class _QuestionTypeButtonState extends State<QuestionTypeButton> {

  final OnPressed onPressed;

  var animationTime = Duration(milliseconds: 50);
  var afterAnimation = Duration(milliseconds: 50);
  var selected = false;
  QuestionType questionType;

  _QuestionTypeButtonState(this.questionType, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onPressed(this.questionType);
          selected = true;
          Future.delayed(afterAnimation, () {
            setState(() {
              selected = false;
            });
          });
        });
      },
      child: AnimatedContainer(
          color: selected
              ? app_colors.PrimaryADarkened
              : app_colors.PrimaryA,
          duration: animationTime,
          curve: Curves.linear,
          child: Container(
            child: QuestionTypeIcon(this.questionType),
            height: kToolbarHeight,
            decoration: BoxDecoration(
              border: Border.all(
                      style: BorderStyle.solid,
                      color: app_colors.PrimaryADarkened
              )
            ),
          )
      ),
    );
  }

}