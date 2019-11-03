import 'package:question_it/questions/question.dart';
import 'package:rxdart/rxdart.dart';

class CreateQuestionBloc {
  BehaviorSubject<Question> _subject;
  Stream<Question> question;

  CreateQuestionBloc({this.question}){
    _subject = new BehaviorSubject<Question>();
    this.question.listen(_subject.add);
    _subject.doOnEach((question) {
      print('Test');
    });
  }

  Stream<Question> get activeQuestion => _subject.asBroadcastStream();

  setActiveQuestion(Question question)
  {
    _subject.sink.add(question);
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