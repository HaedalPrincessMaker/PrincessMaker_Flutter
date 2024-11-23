// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      studentId: json['studentId'] as String,
      nickname: json['nickname'] as String,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'nickname': instance.nickname,
      'fcmToken': instance.fcmToken,
    };
