import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/secret/app_key.dart';
import 'package:flutter_princess_maker/view/alarm_example.dart';
import 'package:flutter_princess_maker/view/login/login_register.dart';
import 'package:flutter_princess_maker/view/login/register/register.dart';
import 'package:flutter_princess_maker/view/mainView/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'dart:async';

void main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '${NATIVE_APP_KEY}',
  );
  runApp(ProviderScope(child: MyAlarm()));
}

class MyAlarm extends StatelessWidget {
  const MyAlarm({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      home: LoginRegister(),
    );
  }
}