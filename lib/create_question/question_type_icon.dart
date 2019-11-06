
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/font.dart';

class QuestionTypeIcon extends StatelessWidget {

  QuestionType questionType;

  final String fibonacciAsset = 'images/poker.svg';


  QuestionTypeIcon(this.questionType);

  @override
  Widget build(BuildContext context) {
    switch(questionType)
    {
      case QuestionType.Number:
        return Center(
         child: Text('1', style: text_style)
        );

      case QuestionType.Emoji:
        return Center(
          child: Text('😀', style: text_style)
        );

      case QuestionType.Fibonacci:
        return Container(
          padding: EdgeInsets.all(5),
         child: SvgPicture.asset(
             fibonacciAsset,
             semanticsLabel: 'Planning Poker'
         ) 
        );

      default:
        return Center(
          child: Text('A', style: text_style)
        );
    }
  }

}