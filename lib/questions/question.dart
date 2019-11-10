import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionType { Number, Letters, Fibonacci, Emoji }

@JsonSerializable(nullable: false)
class Question extends Equatable{

  @JsonKey(nullable: true)
  QuestionType type;
  @JsonKey(nullable: true)
  List<String> users = List<String>();

  int count;
  final String id;

  Question({this.users, this.type, this.count = 1, this.id});

  factory Question.clone(
      Question question,
      {List<String> users, QuestionType type, int count, String id}
      ) {
    return Question(
        type: type ?? question.type,
        count: count ?? question.count,
        id: id ?? question.id,
        users: users ?? question.users);
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return _$QuestionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionToJson(this);
  }

  @override
  List<Object> get props => [users, type, count, id];
}
