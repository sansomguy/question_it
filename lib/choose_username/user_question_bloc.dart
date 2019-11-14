import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/questions/questions.dart';
import 'package:question_it/users/user.dart';
import 'package:question_it/users/users.dart';

/**
 * Events
 */
abstract class UserQuestionEvent {}
class SetActiveQuestionEvent extends UserQuestionEvent {
  final Question question;
  SetActiveQuestionEvent(this.question);
}
class AddUserToQuestionEvent extends UserQuestionEvent{
  User user;
  AddUserToQuestionEvent(this.user);
}

class UserAddedToQuestionEvent extends UserQuestionEvent {
  User user;
  UserAddedToQuestionEvent(this.user);
}

/**
 * States
 */

abstract class UserQuestionState {
  Question question;
  User user;
}
class QuestionAddedState extends UserQuestionState {
  QuestionAddedState(Question question) {
    this.question = question;
  }
}
class NoUserQuestionState extends UserQuestionState {}
class UserQuestionFailureState extends UserQuestionState {}
class UserQuestionAddedState extends UserQuestionState {
  UserQuestionAddedState(Question question, User user) {
    this.question = question;
    this.user = user;
  }
}

class UserQuestionBloc extends Bloc<UserQuestionEvent, UserQuestionState>{

  final UsersRepository usersRepository;
  final QuestionsRepository questionsRepository;

  UserQuestionBloc({@required this.usersRepository, @required this.questionsRepository});

  StreamSubscription<Question> questionSubscription;

  @override
  UserQuestionState get initialState {
    questionSubscription = questionsRepository.activeQuestion.listen((question) => add(SetActiveQuestionEvent(question)));
    return NoUserQuestionState() ;
  }

  @override
  void close() {
    questionSubscription.cancel();
    super.close();
  }

  @override
  Stream<UserQuestionState> mapEventToState(UserQuestionEvent event) async* {
    if(event is SetActiveQuestionEvent || event is UserAddedToQuestionEvent) {
      var user = (event is UserAddedToQuestionEvent)? event.user : state.user;
      var question = (event is SetActiveQuestionEvent)? event.question : state.question;
      if(user != null) {
        yield UserQuestionAddedState(question, user);
      }
      else {
        yield QuestionAddedState(question);
      }
    }
    if(event is AddUserToQuestionEvent) {
      try{
        await this.usersRepository.addOrUpdate(event.user);
        await this.questionsRepository.update(Question.clone(state.question, users: ["${UsersRepository.userCollection}/${event.user.documentId}"]));
        add(UserAddedToQuestionEvent(event.user));
      }catch(_) {
        yield UserQuestionFailureState();
      }
    }
    yield state;
  }

}