import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class FriendSearchDialog extends StatefulWidget {
  @override
  _FriendSearchDialogState createState() => _FriendSearchDialogState();
}

class _FriendSearchDialogState extends State<FriendSearchDialog> {
  TextEditingController _controller = TextEditingController();
  String _friendInfo = "";  // 친구 정보 출력용 변수

  Dio _dio = Dio();

  Future<void> searchFriend(String nickname) async {
    final url = '$myserver/user/name/$nickname';  // 서버 URL을 입력하세요

    try {
      final response = await _dio.get(url);  // GET 요청 보내기

      if (response.statusCode == 200) {
        // 성공적으로 응답 받았을 때
        var data = response.data;
        setState(() {
          fffcm = data['fcmToken'];
          _friendInfo = "선택된 친구의 학번: ${data['studentId'].toString().substring(0,4)} ";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${nickname}님을 찾았습니다.")),
        );
      } else {
        // 친구를 찾지 못했을 때
        setState(() {
          _friendInfo = "친구를 찾을 수 없습니다.";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("친구를 찾을 수 없습니다.")),
        );
      }
    } catch (e) {
      // 예외 처리
      setState(() {
        _friendInfo = "서버 오류가 발생했습니다.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("서버 오류가 발생했습니다.")),
      );
    }
  }// 친구 이름을 입력받을 컨트롤러

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("친구 찾기"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "친구 이름을 입력하세요",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String friendName = _controller.text.trim();  // 친구 이름 가져오기
              if (friendName.isNotEmpty) {
                // 친구 찾기 로직을 추가
                searchFriend(friendName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("친구 이름을 입력해주세요")),
                );
              }
            },
            child: Text("친구 찾기"),
          ),
          Text(_friendInfo),  // 친구 정보 출력
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
          child: Text("확인"),
        ),
      ],
    );
  }
}