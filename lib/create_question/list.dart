import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/font.dart';

typedef AddAnswer(Question question);
typedef RemoveAnswer(Question question);

class CreateQuestionList extends StatelessWidget {

  final Question question;
  final AddAnswer addAnswer;
  final RemoveAnswer removeAnswer;
  final List<String> emojis = '😀,😁,😂,🤣,😃,😄,😅,😆,😉,😊,😋,😎,😍,😘,🥰,😗,😙,😚,☺️,🙂,🤗,🤩,🤔,🤨,😐,😑,😶,🙄,😏,😣,😥,😮,🤐,😯,😪,😫,😴,😌,😛,😜,😝,🤤,😒,😓,😔,😕,🙃,🤑,😲,☹️,🙁,😖,😞,😟,😤,😢,😭,😦,😧,😨,😩,🤯,😬,😰,😱,🥵,🥶,😳,🤪,😵,😡,😠,🤬,😷,🤒,🤕,🤢,🤮,🤧,😇,🤠,🤡,🥳,🥴,🥺,🤥,🤫,🤭,🧐,🤓,😈,👿,👹,👺,💀,👻,👽,🤖,💩,😺,😸,😹,😻,😼,😽,🙀,😿,😾'.split(',').toList(growable: false);

  CreateQuestionList({Key key, this.question, this.addAnswer, this.removeAnswer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedList(
      scrollDirection: Axis.vertical,
      initialItemCount: 2,
      itemBuilder: (context, index, animation) {

        if(question.count < index) {
          return null;
        }

        if(question.count == index) {
          return  GestureDetector(
              onTap: () {
                this.addAnswer(question);
                AnimatedList.of(context).insertItem(index);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1)
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text('+', style: text_style))
              )
          );
        }

        return GestureDetector(
            onTap: () {
              if(question.count == 1) {
                return;
              }
              this.removeAnswer(question);
              AnimatedList.of(context)
                  .removeItem(index, (context, animation) => _builder(context, index, animation));
            },
            child: _builder(context, index, animation)
          );
      },
    );
  }

  _builder(BuildContext context, int index, Animation<double> animation) {

    var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.bounceOut,
        reverseCurve: Curves.easeOutCubic
    );

    return SlideTransition(
        position: curvedAnimation.drive(Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))),
        child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1)
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              child: Center(child: _buildCharacterWidget(question.type, index))
          ),
        );
  }

  _buildCharacterWidget(QuestionType type, int index) {
    switch(type) {

      case QuestionType.Letters: {
        var aIndex = 'A'.codeUnitAt(0);
        return Text('${String.fromCharCode(aIndex + index)}', style: text_style);
      }
      break;
      case QuestionType.Emoji:
        return Text(emojis.length > index ? emojis[index] : 'No more emojis!!!', style: text_style);
      break;

      case QuestionType.Number:
      default:
        return Text('${index + 1}', style: text_style);
      break;


    }
  }

}