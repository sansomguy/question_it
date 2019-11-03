import 'dart:collection';

import 'package:question_it/questions/question.dart';

class QuestionsRepository {

  final Map<String, Question> allQuestions = HashMap();

  Future<Question> create(Question question) {
    allQuestions.putIfAbsent(question.id, () => question);
    return Future.delayed(Duration(seconds: 1) , () => question);
  }

  Future<Question> get(String id) {

    if(!allQuestions.containsKey(id))
      return Future.error(QuestionDoesNotExist(id));

    return Future.delayed(Duration(seconds: 3), () => allQuestions[id]);
  }
}

class QuestionDoesNotExist {
  final String questionId;
  QuestionDoesNotExist(this.questionId);
}