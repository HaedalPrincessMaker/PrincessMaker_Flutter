import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

import '../../const.dart';
import '../../sendPushNotification.dart';

class NotificationUi extends StatefulWidget {
  @override
  State<NotificationUi> createState() => _NotificationUiState();
}

class _NotificationUiState extends State<NotificationUi> {
  String _friendsToken = "";
  String _alertMessage = "";

  Dio _dio = Dio();

  Future<void> getFriendsToken(String nickname) async {
    final url = '$myserver/user/name/$nickname';  // 서버 URL을 입력하세요

    try {
      final response = await _dio.get(url);  // GET 요청 보내기

      if (response.statusCode == 200) {
        // 성공적으로 응답 받았을 때
        var data = response.data;
        setState(() {
          _friendsToken = data['fcmToken'];
          _alertMessage = "${nickname}님이 보냈습니다.";
        });
      } else {
        // 친구를 찾지 못했을 때
        setState(() {
          _friendsToken = "";
          _alertMessage = "친구를 찾을 수 없습니다.";
        });
      }
    } catch (e) {
      print(e);
      // 예외 처리
      setState(() {
        _friendsToken = "";
        _alertMessage = "[ERROR] : 다시 시도해주세요";
      });
    }
  }

  void sendApproveNotification({
    required String friendsToken,
}) {
    String token = friendsToken; // FCM 토큰
    String title = "[승인완료] - 알람이 승인되었습니다";
    String body = "승인완료";

    sendPushNotification(token, title, body);
  }

  void showAlert(String type, String nickname) async {
    // 친구의 토큰을 가져오는 비동기 작업
    await getFriendsToken(nickname);

    if (_friendsToken.isEmpty) {
      // 토큰이 없으면 다이얼로그를 띄우지 않음
      return;
    }

    // AlertDialog 표시
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(type),
          content: Text(_alertMessage), // 전달된 message를 Dialog에 표시
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () async {
                sendApproveNotification(friendsToken: _friendsToken);
                await Future.delayed(Duration(seconds: 1)); // 1초 지연
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text("승인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _text = TextStyle(
      fontSize: garo(context, 0.05),
      fontFamily: 'Hakgyo',
    );

    return SafeArea(
      child: ListView.builder(
        itemCount: notice.length,
        itemBuilder: (context, index) {
          final notification = notice.reversed.toList()[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: GestureDetector(
                onTap: () async {
                  String type = notification.split(":")[0].substring(0, 6);
                  String nickname = notification.split(":")[2].trim();
                  showAlert(type, nickname); // 다이얼로그 호출
                },
                child: Text(
                  notification.split(":")[0],
                  style: _text,
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
