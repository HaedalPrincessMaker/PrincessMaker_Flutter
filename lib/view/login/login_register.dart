import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/text_widget/logo.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

import '../../function/kakao_login.dart';


class LoginRegister extends StatelessWidget {
  const LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sero(context, 0.4),
              ),
              getLogo(context: context, width: 0.2),
              SizedBox(
                height: sero(context, 0.195),
              ),
              Text(
                "내 의지로 시작되는 아침",
                style: TextStyle(
                    fontFamily: 'Hakgyo',
                    fontSize: garo(context, 0.06),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: sero(context, 0.015),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
                child: GestureDetector(
                  onTap: () async {
                    kakaoLogin();
                  },
                  child: Image.asset(
                    'asset/image/kakao_login.png',
                  ),
                ),
              ),
              SizedBox(
                height: sero(context, 0.08),
              ),
              teamName(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget teamName({required BuildContext context}) {
  double fontSize = 0.025;
  return Column(
    children: [
      Text(
        "@mady By",
        style: TextStyle(
            fontFamily: 'Hakgyo',
            fontSize: garo(context, fontSize),
            fontWeight: FontWeight.w500),
      ),
      Text(
        "Princess Maker",
        style: TextStyle(
            fontFamily: 'Hakgyo',
            fontSize: garo(context, fontSize),
            fontWeight: FontWeight.w500),
      ),
    ],
  );
}
