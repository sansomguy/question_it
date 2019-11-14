import 'package:bloc/bloc.dart';
import 'package:question_it/questions/question.dart';
import 'package:question_it/questions/questions.dart';
import 'package:uuid/uuid.dart';

/**
 * Events
 */
abstract class StartScreenEvent {}
class CreateQuestionEvent extends StartScreenEvent{}

/**
 * State
 */
class StartScreenState {}
class QuestionCreationCompleted extends StartScreenState {}

class StartScreenBloc extends Bloc<StartScreenEvent, StartScreenState> {

  final QuestionsRepository questionsRepository;

  StartScreenBloc(this.questionsRepository);

  @override
  StartScreenState get initialState => StartScreenState();

  @override
  Stream<StartScreenState> mapEventToState(StartScreenEvent event) async* {
    if(event is CreateQuestionEvent) {
      var question = Question(id: Uuid().v1());
      try {
        await questionsRepository.create(question);
        yield QuestionCreationCompleted();
      } catch(_) {
        yield state;
      }
    }
  }
}