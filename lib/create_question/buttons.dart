import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/question_type_icon.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/borders.dart';
import 'package:question_it/settings/colors.dart' as app_colors;


typedef OnPressed(QuestionType type);


class QuestionTypeButton extends StatefulWidget {

  final OnPressed onPressed;
  QuestionType questionType;
  QuestionTypeButton({Key key, this.questionType, this.onPressed}) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionTypeButtonState();
  }
}

class _QuestionTypeButtonState extends State<QuestionTypeButton> {

  var animationTime = Duration(milliseconds: 50);
  var afterAnimation = Duration(milliseconds: 50);
  var selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.widget.onPressed(this.widget.questionType);
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
            child: QuestionTypeIcon(this.widget.questionType),
            height: kToolbarHeight,
            decoration: BoxDecoration(
              border: Border.all(
                      style: BorderStyle.solid,
                      width: border_width/2,
                      color: app_colors.PrimaryADarkened
              )
            ),
          )
      ),
    );
  }

}