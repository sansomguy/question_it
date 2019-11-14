import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_it/buttons/circle.dart';
import 'package:question_it/buttons/start_docked.dart';
import 'package:question_it/choose_username/screen.dart';
import 'package:question_it/create_question/header.dart';
import 'package:question_it/create_question/list.dart';
import 'package:question_it/create_question/list_logic.dart';
import 'package:question_it/create_question/create_question_bloc.dart';
import 'package:question_it/questions/questions.dart';
import 'package:question_it/settings/colors.dart' as app_colors;

class CreateQuestionScreen extends StatelessWidget {
  final QuestionsListLogic listBloc = QuestionsListLogic();
  CreateQuestionScreen();

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
          floatingActionButtonLocation: CustomFloatingActionButtonLocation.startDocked,
        ),
      )
    );
  }

  _buildContent() {
    return Container(
      color: app_colors.backgroundPrimary,
      child: BlocProvider<CreateQuestionBloc>(
        builder: (context) => CreateQuestionBloc(
          RepositoryProvider.of<QuestionsRepository>(context),
        ),
          child: BlocBuilder<CreateQuestionBloc, QuestionState>(
              builder: (context, state) {
                // ignore: close_sinks
                var bloc = BlocProvider.of<CreateQuestionBloc>(context);
                if(state is ActiveQuestionState) {
                  return Column(
                    children: [
                      CreateQuestionHeader(onTypeSet: (type) {
                        bloc.add(SetQuestionTypeEvent(question: state.question, type: type));
                      }),
                      Expanded(
                          child: CreateQuestionList(
                            question: state.question,
                            addAnswer: (_) {
                              bloc.add(AddAnswerEvent(_));
                            },
                            removeAnswer: (_) {
                              bloc.add(RemoveAnswerEvent(_));
                            },
                            fibonacci: listBloc.fibonacci,
                            emojis: listBloc.emojis,
                          ))
                    ],
                  );
                }
                return Icon(Icons.wb_cloudy);
              }
          ),
        ),
      );
  }
}
