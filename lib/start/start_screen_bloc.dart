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

class StartScreenEvent extends Equatable{

  String type;
  Question question;
  StartScreenEvent({this.type, this.question});

  @override
  List<Object> get props => [this.type, this.question];
}

class StartScreenState {
  Question question;
  StartScreenState({this.question});
}


class StartScreenBloc {

  final questionsRepository = QuestionsRepository();
  final BuildContext context;
  
  StartScreenBloc({this.context});

  void createQuestion() {
    var question = Question(id: Uuid().v1());
    var subject = BehaviorSubject<Question>();
    subject.sink.add(question);
    var stream = questionsRepository.create(question).asStream();
    stream.listen(subject.add);
    navigateToCreate(subject);
  }

  void navigateToCreate(Observable<Question> createdQuestion) {
    Navigator
      .of(context)
      .push(
        MaterialPageRoute(
            builder: (context) => CreateQuestionScreen(
                bloc: CreateQuestionBloc(question: createdQuestion.asBroadcastStream())
            )
        )
      );
  }
}