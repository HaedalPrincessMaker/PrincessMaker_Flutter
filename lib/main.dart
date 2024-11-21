import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/secret/app_key.dart';
import 'package:flutter_princess_maker/view/login/login_register.dart';
import 'package:flutter_princess_maker/view/login/register/register_a.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';


void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '${NATIVE_APP_KEY}',
  );
  runApp(ProviderScope(child: Alarm()));
}

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      home: RegisterA(),
    );
  }
}