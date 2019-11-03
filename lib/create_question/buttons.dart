import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/question_type_icon.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class QuestionTypeButton extends StatefulWidget {

  QuestionType questionType;
  QuestionTypeButton({Key key, this.questionType}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionTypeButtonState(questionType);
  }
}

class _QuestionTypeButtonState extends State<QuestionTypeButton> {

  var animationTime = Duration(milliseconds: 300);
  var afterAnimation = Duration(milliseconds: 300);
  var selected = false;
  QuestionType questionType;

  _QuestionTypeButtonState(this.questionType);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
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
          curve: Curves.fastOutSlowIn,
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