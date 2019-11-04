import 'package:question_it/questions/question.dart';
import 'package:rxdart/rxdart.dart';

class CreateQuestionBloc {
  BehaviorSubject<Question> _subject;
  CreateQuestionBloc({Stream<Question> question}){
    _subject = new BehaviorSubject<Question>();
    question.listen((question){
      print('Its here');
    });
    question.listen(_subject.add);
  }

  Stream<Question> get activeQuestion => _subject.asBroadcastStream();

  setActiveQuestion(Question question)
  {
    _subject.sink.add(question);
  }

  addAnswer(Question question) {
    var updatedQuestion = Question.clone(question, count: question.count + 1);
    _subject.sink.add(updatedQuestion);
  }

  removeAnswer(Question question) {
    var updatedQuestion = Question.clone(question, count: question.count - 1);
    _subject.sink.add(updatedQuestion);
  }

  setType(Question question, QuestionType type) {
    var updatedQuestion = Question.clone(question, type: type);
    _subject.sink.add(updatedQuestion);
  }

  removeActiveQuestion()
  {
    _subject.sink.add(null);
  }

  void dispose()
  {
    _subject.close();
  }
}