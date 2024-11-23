import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/common/text_widget/input.dart';
import 'package:flutter_princess_maker/view/login/register/register_frame.dart';
import 'package:flutter_princess_maker/view/mainView/root_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common/emptyBox.dart';
import '../../const.dart';
import '../../json/member.dart';
import '../../storage/pm_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ScrollController scrollController;

  final TextEditingController studentIDController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 초기화
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    studentIDController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  void _scrollToFocusedField(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.hasFocus) {
      // 현재 포커스된 위젯 위치로 스크롤
      scrollController.animateTo(
        scrollController.offset + sero(context, 0.35), // 적절한 높이로 조정
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegisterFrame(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        children: [
          emptyBox(context, 0.3),
          Padding(
            padding: EdgeInsets.all(garo(context, 0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "학번",
                  style: TextStyle(
                      fontFamily: 'Hakgyo', fontSize: garo(context, 0.05)),
                ),
                emptyBox(context, 0.015),
                textInputBox(
                    context: context,
                    controller: studentIDController,
                    onTap: () => _scrollToFocusedField(context),
                    onChanged: (text) {
                      print('studentID: $text');
                    },
                    hintText: "학번을 입력해주세요",
                    fontSize: garo(context, 0.04)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "닉네임",
                  style: TextStyle(
                      fontFamily: 'Hakgyo', fontSize: garo(context, 0.05)),
                ),
                emptyBox(context, 0.015),
                textInputBox(
                    context: context,
                    controller: nicknameController,
                    onTap: () => _scrollToFocusedField(context),
                    onChanged: (text) {
                      print('nickname: $text');
                    },
                    hintText: "닉네임을 입력해주세요",
                    fontSize: garo(context, 0.04)),
                emptyBox(context, 0.02),
                pmbutton(
                  context: context,
                  buttonText: '로그인',
                  onpressed: () async {
                    ssid = studentIDController.text.trim();
                    sname = nicknameController.text.trim();
                    String? temp = storage["fcm"];
                    print("temp : " + temp!);
                    Member newMember = Member(
                      studentId: studentIDController.text.trim(),
                      nickname: nicknameController.text.trim(),
                      fcmToken: temp!,
                    );
                    int result = await doLogin(newMember);
                    if(result<=200){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => RootTab()), // NewPage()를 원하는 페이지로 교체하세요
                      );
                      Fluttertoast.showToast(msg: "로그인 완료.", gravity: ToastGravity.CENTER);
                    } else {
                      Fluttertoast.showToast(msg: "로그인에 실패하였습니다", gravity: ToastGravity.CENTER);
                    }
                    studentIDController.text = "";
                    nicknameController.text = "";

                    print("click 로그인 완료");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
