import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_princess_maker/view/login/login_register.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  waitForShowingSplash();
  FlutterNativeSplash.remove();
  runApp(const Alarm());
}

Future<void> waitForShowingSplash() async {
  await Future.delayed(Duration(seconds: 2));
}

void printHello() {
  print("Hello");
}

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginRegister(),
    );
  }
}