import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/emptyBox.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

import '../../const.dart';

class MyProfileUi extends StatefulWidget {
  const MyProfileUi({super.key});

  @override
  State<MyProfileUi> createState() => _MyProfileUiState();
}

class _MyProfileUiState extends State<MyProfileUi> {
  String? studentId;
  String? nickname;
  String? fcmToken;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMyInfo();
  }

  void getMyInfo() async {
    Dio dio = Dio();

    try {
      // 사용자 ID를 서버에서 가져와야 하는 경우, 예시로 1을 사용
      int userId = 1;

      // 서버에서 해당 ID에 대한 정보를 가져오기 위한 GET 요청
      Response resp = await dio.get(
        '$myserver/user/$userId', // 서버 URL과 ID를 결합
      );

      if (resp.statusCode == 200) {
        // 성공적으로 응답을 받으면 사용자 정보 처리
        var data = resp.data;
        setState(() {
          studentId = data['studentId'];
          nickname = data['nickname'];
          fcmToken = data['fcmToken'];
          isLoading = false;
        });
      } else {
        print('서버 오류: ${resp.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('에러 발생: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 중 표시
          : Column(
              children: [
                emptyBox(context, 0.1),
                // 프로필 이미지를 나타내는 부분
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  width: garo(context, 0.75),
                  height: garo(context, 0.75),
                  child: ClipOval(
                    child: Image.asset(
                      'asset/image/knu.png', // 여기에 프로필 이미지 URL 넣기
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: sero(context, 0.1)),
                // 닉네임과 함께 표시
                Text(
                  nickname ?? "닉네임 없음",
                  style: TextStyle(
                    fontFamily: 'Gugi',
                    fontSize: garo(context, 0.2),
                  ),
                  softWrap: true,
                ),
                emptyBox(context, 0.1),
                // 사용자 ID와 FCM Token 표시
                Text("학생 ID: ${studentId ?? "정보 없음"}"),
              ],
            ),
    );
  }
}
