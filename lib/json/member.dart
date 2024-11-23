import 'dart:ffi';

import 'package:flutter_princess_maker/storage/pm_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_princess_maker/const.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String studentId;
  final String nickname;
  final String fcmToken;

  Member({required this.studentId, required this.nickname, required this.fcmToken});

  // Generated fromJson and toJson methods.
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

Future<int> sendMemberData(Member member) async {
  Dio dio = Dio();

  try {
    // API endpoint URL
    String url = myserver;

    // Member 객체를 JSON으로 직렬화
    Map<String, dynamic> memberJson = member.toJson();

    // POST 요청 보내기
    Response response = await dio.post(
      url + "/user/register",
      data: memberJson,
    );

    if (response.statusCode == 200) {
      print('회원가입 성공: ${response.data}');
      return response.statusCode!;
    } else {
      print('회원가입 실패: ${response.statusCode}');
      return response.statusCode!;
    }
  } catch (e) {
    print('오류 발생: $e');
    return 500;
  }
}

Future<int> doLogin(Member member) async {
  Dio dio = Dio();

  try {
    // API endpoint URL
    String url = myserver;

    // Member 객체를 JSON으로 직렬화
    Map<String, dynamic> memberJson = member.toJson();

    // POST 요청 보내기
    Response response = await dio.post(
      url + "/user/login",
      data: memberJson,
    );

    String myId = response.data["userId"];
    storage["userId"] = myId;
    // print("userId : " + response.data["userId"]);

    if (response.statusCode == 200) {
      print('로그인 성공: ${response.data}');
      return response.statusCode!;
    } else {
      print('로그인 실패: ${response.statusCode}');
      return response.statusCode!;
    }
  } catch (e) {
    print('오류 발생: $e');
    return 500;
  }
}