import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/view/add_alarm.dart';

class AlarmListUi extends StatefulWidget {
  const AlarmListUi({super.key});

  @override
  State<AlarmListUi> createState() => _AlarmListUiState();
}

class _AlarmListUiState extends State<AlarmListUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _addAlarmButton(),
          SliverList.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: garo(context, 0.025)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  height: sero(context, 0.1), // 예시 높이 설정
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("시간"),
                      Column(
                        children: [Text("on/off button"), Text("수정/삭제")],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              // 항목 사이에 구분선 추가
              return SizedBox(
                height: sero(context, 0.01),
              );
            },
            itemCount: 10, // 예시: 10개의 항목 표시
          ),
        ],
      ),
    );
  }

  SliverPadding _addAlarmButton() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: garo(context, 0.025)),
      sliver: SliverToBoxAdapter(
        child: pmbutton(
          context: context,
          buttonText: "알람 추가",
          onpressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddAlarm())),
        ),
      ),
    );
  }
}
