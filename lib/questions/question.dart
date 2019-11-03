enum QuestionType {
  Number,
  Letters,
  Emoji,
  Prime
}

class Question {
  QuestionType type;
  int count;
  String id;
  Question({this.type, this.count, this.id});
}
