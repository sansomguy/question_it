import 'package:bloc/bloc.dart';
import 'package:question_it/users/users.dart';
import 'user.dart';

/**
 * Event
 */
abstract class UserEvent {}
class SetUserEvent extends UserEvent{
  final User user;
  SetUserEvent(this.user);
}

/**
 * State
 */

abstract class UserState {}
class NoUserState extends UserState {}
class CreatingUserState extends UserState {}
class ActiveUserState extends UserState {
  final User user;
  ActiveUserState(this.user);
}

/**
 * Bloc
 */
class UserBloc extends Bloc<UserEvent, UserState> {

  final UsersRepository usersRepository;

  UserBloc(this.usersRepository);

  @override
  UserState get initialState => NoUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is SetUserEvent) {
      yield CreatingUserState();
      try {
        await usersRepository.addOrUpdate(event.user);
        yield ActiveUserState(event.user);

      }
      catch(_) {
        yield state;
      }
    }
    yield state;
  }
}