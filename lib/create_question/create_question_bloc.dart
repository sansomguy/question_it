import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/questions/questions.dart';
import 'package:uuid/uuid.dart';

/**
 * Event
 */

abstract class QuestionEvent {}

class SetActiveQuestionEvent extends QuestionEvent {
  final Question question;
  SetActiveQuestionEvent(this.question);
}

class CreateQuestionEvent extends QuestionEvent {}

class AddAnswerEvent extends QuestionEvent {
  final Question question;
  AddAnswerEvent(this.question);
}

class RemoveAnswerEvent extends QuestionEvent {
  final Question question;
  RemoveAnswerEvent(this.question);
}

class SetQuestionTypeEvent extends QuestionEvent {
  final Question question;
  final QuestionType type;
  SetQuestionTypeEvent({@required this.question, @required this.type});
}

/**
 * State
 */
abstract class QuestionState {}

class NoQuestionState extends QuestionState {
}

class ActiveQuestionState extends QuestionState with EquatableMixin{
  final Question question;
  ActiveQuestionState(this.question);

  @override
  List<Object> get props => [question];
}

class CreateQuestionCompleteState extends QuestionState {}

class CreateQuestionBloc extends Bloc<QuestionEvent, QuestionState> {

  final QuestionsRepository questionsRepository;
  StreamSubscription<Question> subscription;

  CreateQuestionBloc(this.questionsRepository);

  @override
  QuestionState get initialState {

    subscription = questionsRepository.activeQuestion.listen((activeQuestion) {
      add(SetActiveQuestionEvent(activeQuestion));
    });
    return NoQuestionState();
  }

  @override
  void close() {
    subscription.cancel();
    super.close();
  }

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {

    if(event is AddAnswerEvent) {
      var updatedQuestion = Question.clone(event.question, count: (event.question.count + 1));
      yield ActiveQuestionState(updatedQuestion);
      try{
        await questionsRepository.update(updatedQuestion);
      }catch(_) {
        yield state;
      }
    }

    if(event is RemoveAnswerEvent) {
      var updatedQuestion = Question.clone(event.question, count: (event.question.count-1));
      yield ActiveQuestionState(updatedQuestion);
      try{
        await questionsRepository.update(updatedQuestion);
      }catch(_) {
        yield state;
      }
    }

    if(event is SetQuestionTypeEvent) {
      var updatedQuestion = Question.clone(event.question, type: event.type);
      yield ActiveQuestionState(updatedQuestion);
      try{
        await questionsRepository.update(updatedQuestion);
      }catch(_) {
        yield state;
      }
    }

    if(event is SetActiveQuestionEvent) {
      if(event.question != null){
        yield ActiveQuestionState(event.question);
      } else {
        yield NoQuestionState();
      }
    }
  }
}

