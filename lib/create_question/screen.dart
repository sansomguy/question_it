import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/create_question_bloc.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/colors.dart' as app_colors;
import 'buttons.dart';

class CreateQuestionScreen extends StatefulWidget {
  final CreateQuestionBloc bloc;
  CreateQuestionScreen({this.bloc});
  @override
  State<StatefulWidget> createState() {
    return _CreateQuestionState(bloc: this.bloc);
  }
}

class _CreateQuestionState extends State<CreateQuestionScreen> {
  final CreateQuestionBloc bloc;

  TextTheme textTheme;
  IconThemeData iconTheme;
  bool selected = false;

  _CreateQuestionState({this.bloc});

  @override
  void didChangeDependencies() {
    var theme = Theme.of(context);

    textTheme = TextTheme(
      title: TextStyle(color: Colors.black),
    ).merge(theme.textTheme);

    iconTheme = IconThemeData(color: Colors.black);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: app_colors.backgroundPrimary,
          child: Column(
              children: [
      SafeArea(
            child: Container(
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
                        child: QuestionTypeButton(
                            questionType: QuestionType.Letters),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child:
                            QuestionTypeButton(questionType: QuestionType.Number),
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: QuestionTypeButton(
                              questionType: QuestionType.Emoji))
                    ]
                )
            )
      ),
      Container(
          child: StreamBuilder(
            stream: this.bloc.activeQuestion,
            initialData: Question(),
            builder: (context, AsyncSnapshot<Question> snapshot) =>
                Text('${snapshot.data.id}'),
          ),
      )
    ]),
        ));
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}
