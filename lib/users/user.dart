import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';


@JsonSerializable(nullable: false)
class User {
  final String username;
  User(this.username);

  toJson() {
    return _$UserToJson(this);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}