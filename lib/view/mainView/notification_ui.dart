import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

class NotificationUi extends StatelessWidget {
  const NotificationUi({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle _text = TextStyle(
      fontSize: garo(context, 0.05),
      fontFamily: 'Hakgyo',
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black)
                )
              ),
              child: Text("일반적인 알림 메시지인 경우에 사용됩니다", style: _text, softWrap: true,),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black)
                  )
              ),
              child: Row(
                children: [
                  Text("친구 요청 메시지인 경우에 사용됩니다", style: _text, softWrap: true,),
                  Text("수락/거절")
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black)
                  )
              ),
              child: Row(
                children: [
                  Text("알람 승인 요청 메시지", style: _text, softWrap: true,),
                  Text("확인")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
