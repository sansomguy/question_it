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
class AddUserToQuestionEvent extends UserQuestionEvent{
  User user;
  AddUserToQuestionEvent(this.user);
}

/**
 * States
 */

abstract class UserQuestionState {}
class NoUserQuestionState extends UserQuestionState {}
class UserQuestionFailureState extends UserQuestionState {}
class UserQuestionAddedState extends UserQuestionState {}

class UserQuestionBloc extends Bloc<UserQuestionEvent, UserQuestionState>{

  final UsersRepository usersRepository;
  final QuestionsRepository questionsRepository;

  UserQuestionBloc({@required this.usersRepository, @required this.questionsRepository});

  @override
  UserQuestionState get initialState => NoUserQuestionState();

  @override
  Stream<UserQuestionState> mapEventToState(UserQuestionEvent event) async* {
    if(event is AddUserToQuestionEvent) {
      try{
        await this.usersRepository.addOrUpdate(event.user);
        await this.questionsRepository.update(Question.clone(questionsRepository.activeQuestion, users: ["${UsersRepository.userCollection}/${event.user.documentId}"]));
        yield UserQuestionAddedState();
      }catch(_) {
        yield UserQuestionFailureState();
      }
    }

    yield state;
  }

}