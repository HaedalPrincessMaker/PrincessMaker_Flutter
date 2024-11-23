import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/emptyBox.dart';

import '../../common/button/pmbutton.dart';
import '../../common/react_size.dart';
import '../alarm_example.dart';
import '../friend_search_dialog.dart';

class QuizUi extends StatelessWidget {
  const QuizUi({super.key});

  @override
  Widget build(BuildContext context) {
    final AlarmExample alarmExample = AlarmExample();
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              emptyBox(context, 0.2),
              Text("친구에게 알람 종료를 요청하세요!"),
              emptyBox(context, 0.1),
              SizedBox(
                width: garo(context, 0.758),
                child: Center(
                  child: pmbutton(
                    context: context,
                    buttonText: "친구찾기",
                    onpressed: () {
                      // 버튼 클릭 시 showDialog 실행
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FriendSearchDialog();
                        },
                      );
                    },
                  ),
                ),
              ),
              emptyBox(context, 0.3),
              Center(
                    child: alarmExample.getCancleButton(),
                  ),
            ],
          ),
        ));
  }
}
