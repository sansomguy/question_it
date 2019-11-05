import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/create_question/create_question_bloc.dart';
import 'package:question_it/create_question/screen.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/questions/questions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

const createQuestion = "createQuestion";
const findQuestion = "findQuestion";

class StartScreenBloc {

  final questionsRepository = QuestionsRepository();
  StartScreenBloc();

  void createQuestion(BuildContext context) {
    var question = Question(id: Uuid().v1());
    var subject = BehaviorSubject<Question>();
    subject.sink.add(question);
    var stream = questionsRepository.create(question).asStream();
    stream.listen(subject.add);
    final bloc = CreateQuestionBloc(question: subject.asBroadcastStream());
    navigateToCreate(bloc, context);
  }

  void navigateToCreate(CreateQuestionBloc bloc, BuildContext context) {
    Navigator
      .of(context)
      .push(
        MaterialPageRoute(
            builder: (context) => CreateQuestionScreen(bloc: bloc)
        )
      );
  }
}