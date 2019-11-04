enum QuestionType {
  Number,
  Letters,
  Emoji,
  Prime
}

class Question {
  final QuestionType type;
  final int count;
  final String id;
  Question({this.type, this.count = 1, this.id});

  Question.clone(Question question, { QuestionType type, int count, String id}):
        this(
          type: type ?? question.type,
          count: count ?? question.count,
          id: id ?? question.id
      );
}
