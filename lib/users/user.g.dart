// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['username'] as String,
  )..documentId = json['documentId'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'username': instance.username,
    };
