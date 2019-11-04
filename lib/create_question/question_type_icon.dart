
import 'package:flutter/material.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/font.dart';

class QuestionTypeIcon extends StatelessWidget {

  QuestionType questionType;

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
        return Icon(Icons.tag_faces, size: font_size);

      default:
        return Center(
          child: Text('A', style: text_style)
        );
    }
  }

}