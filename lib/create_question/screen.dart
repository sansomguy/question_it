import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/create_question_bloc.dart';
import 'package:question_it/create_question/header.dart';
import 'package:question_it/create_question/list.dart';
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

  _CreateQuestionState({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: app_colors.backgroundPrimary,
                child: StreamBuilder(
                    stream: this.bloc.activeQuestion,
                    initialData: Question(),
                    builder: (context, AsyncSnapshot<Question> snapshot) =>
                        Column(children: [
                          CreateQuestionHeader(
                              onTypeSet: (type) {
//                                this.bloc.setType(snapshot.data, type)
                                print('TEsting the things');
                              }
                          ),
                          Expanded(
                              child: CreateQuestionList(
                                  question: snapshot.data,
                                  addAnswer: bloc.addAnswer,
                                  removeAnswer: bloc.removeAnswer))
                        ])))));
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}
