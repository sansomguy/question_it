
import 'package:flutter/material.dart';
import 'package:question_it/questions/question.dart';

class QuestionTypeIcon extends StatelessWidget {

  QuestionType questionType;

  QuestionTypeIcon(this.questionType);

  @override
  Widget build(BuildContext context) {
    switch(questionType)
    {
      case QuestionType.Number:
        return Center(
         child: Text('1')
        );

      case QuestionType.Emoji:
        return Icon(Icons.tag_faces);

      default:
        return Center(
          child: Text('A')
        );
    }
  }

}