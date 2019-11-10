import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/buttons/circle.dart';
import 'package:question_it/buttons/start_docked.dart';
import 'package:question_it/choose_username/screen.dart';
import 'package:question_it/create_question/create_question_bloc.dart';
import 'package:question_it/create_question/header.dart';
import 'package:question_it/create_question/list.dart';
import 'package:question_it/create_question/list_bloc.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class CreateQuestionScreen extends StatelessWidget {
  final CreateQuestionBloc bloc;
  final CreateQuestionListBloc listBloc = CreateQuestionListBloc();
  CreateQuestionScreen({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.PrimaryA,
      child: SafeArea(
        child: Scaffold(
          body: Scaffold(
            body: _buildContent(),
            floatingActionButton: CircleButton(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseUserNameScreen())),
              iconData: Icons.check,
            ),
          ),
          floatingActionButton: CircleButton(
            onTap: () => Navigator.of(context).pop(),
            iconData: Icons.close,
          ),
          floatingActionButtonLocation:
          CustomFloatingActionButtonLocation.startDocked,
        ),
      )
    );
  }

  _buildContent() {
    return Container(
      color: app_colors.backgroundPrimary,
      child: StreamBuilder(
        stream: this.bloc.activeQuestion,
        builder: (context, AsyncSnapshot<Question> snapshot) => Column(
          children: [
            CreateQuestionHeader(onTypeSet: (type) {
              this.bloc.setType(snapshot.data, type);
            }),
            Expanded(
                child: CreateQuestionList(
              question: snapshot.data,
              addAnswer: bloc.addAnswer,
              removeAnswer: bloc.removeAnswer,
              fibonacci: listBloc.fibonacci,
              emojis: listBloc.emojis,
            ))
          ],
        ),
      ),
    );
  }
}
