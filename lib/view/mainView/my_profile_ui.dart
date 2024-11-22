import 'package:flutter/material.dart';

class MyProfileUi extends StatelessWidget {
  const MyProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Row(
          children: [
            Text("이미지처럼 보이는 컨테이너"),
            Text("닉네임"),
          ],
        ),
        Text("친구 추가"),
        Text("친구 목록")
      ],
    ));
  }
}
