import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/emptyBox.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/view/add_alarm.dart';
import 'package:flutter_princess_maker/view/alarm_example.dart' as af;

import '../../storage/alarm_storage.dart';
import '../editAlarm.dart';

class AlarmListUi extends StatefulWidget {
  const AlarmListUi({super.key});

  @override
  State<AlarmListUi> createState() => _AlarmListUiState();
}

class _AlarmListUiState extends State<AlarmListUi> {
  List<AlarmInfo> myAlarms = alarms;

  @override
  void initState() {
    super.initState();
    for (AlarmInfo alarm in myAlarms) {
      doSetWeeklyAlarm(alarm); // 알람 설정 호출
    }
  }

  // AlarmExample 인스턴스를 생성하여 setWeeklyAlarm 호출
  void doSetWeeklyAlarm(AlarmInfo alarm) async {
    af.AlarmExample alarmExample = af.AlarmExample();
    if(alarm.isApproved) {
      await alarmExample.setWeeklyAlarm(
        timeOfDay: alarm.timeOfDay!,
        selectedDays: alarm.selectedDays!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _addAlarmButton(),
          SliverList.separated(
            itemBuilder: (BuildContext context, int index) {
              final alarm = myAlarms[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditAlarmScreen(alarm: alarm, index: index),
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: garo(context, 0.025)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    height: sero(context, 0.1), // 알람 항목 높이 설정
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 알람 시간과 요일 표시
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            emptyBox(context, 0.01),
                            Text(
                              "알람 시간: ${_formatTime(alarm.timeOfDay!)}",
                              style: TextStyle(fontFamily: 'Hakgoy', fontSize: garo(context, 0.06)),
                            ),
                            Text(
                              "알람 요일: ${alarm.selectedDays?.join(', ')}",
                              style: TextStyle(fontFamily: 'Gugi', fontSize: garo(context, 0.04)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: garo(context, 0.15),
                          child: (alarm.isApproved) ? Icon(Icons.edit_attributes_rounded) : Icon(Icons.edit_attributes_outlined)
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: sero(context, 0.01)); // 항목 사이의 공간 추가
            },
            itemCount: myAlarms.length, // 알람 리스트의 길이
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

  // TimeOfDay 객체를 문자열로 포맷하는 헬퍼 함수
  String _formatTime(TimeOfDay time) {
    final hour = time.hour < 10 ? "0${time.hour}" : time.hour.toString();
    final minute = time.minute < 10 ? "0${time.minute}" : time.minute.toString();
    return "$hour:$minute";
  }
}
