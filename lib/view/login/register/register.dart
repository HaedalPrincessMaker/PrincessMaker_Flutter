import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/common/text_widget/input.dart';
import 'package:flutter_princess_maker/json/member.dart';
import 'package:flutter_princess_maker/view/login/register/register_frame.dart';

import '../../../common/emptyBox.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          emptyBox(context, 0.2),
          Image.asset(
            'asset/image/knu.png',
            width: garo(context, 0.1),
            height: sero(context, 0.1),
          ),
          emptyBox(context, 0.2),
          Padding(
            padding: EdgeInsets.all(garo(context, 0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "1. 경북대학교의 학번을 입력해주세요!",
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
                  "2. 사용할 닉네임을 입력해주세요",
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
                  buttonText: '회원가입 완료',
                  onpressed: () {
                    Member newMember = Member(
                      studentId: '12345',
                      nickname: 'JohnDoe',
                    );
                    sendMemberData(newMember);
                    print("click 회원가입 완료");
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
