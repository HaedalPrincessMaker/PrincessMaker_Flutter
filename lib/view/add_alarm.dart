import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/emptyBox.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/view/default_layout.dart';
import 'package:flutter_princess_maker/view/mainView/alarm_list_ui.dart';
import 'package:flutter_princess_maker/view/mainView/root_tab.dart';

import '../storage/alarm_storage.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  TimeOfDay initialTime = TimeOfDay.now();
  List<String> selectedDays = [];  // Store selected days of the week

  @override
  Widget build(BuildContext context) {
    TextStyle _questionStyle = TextStyle(
      fontFamily: 'Hakgyo',
      fontSize: garo(context, 0.075),
    );

    return DefaultLayout(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              emptyBox(context, 0.1),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    hourLabelText: "시",
                    minuteLabelText: "분",
                    cancelText: "취소",
                    confirmText: "확인",
                    initialEntryMode: TimePickerEntryMode.input,
                    helpText: "알람 시간 설정",
                    barrierColor: Colors.white,
                    context: context,
                    initialTime: initialTime,
                  );
                  if (timeOfDay != null) {
                    setState(() {
                      initialTime = timeOfDay;
                    });
                  }
                },
                child: Text(
                  _timeButtonText(initialTime),
                  style: _questionStyle.copyWith(fontSize: garo(context, 0.125)),
                ),
              ),
              emptyBox(context, 0.1),
              Text(
                "요일 설정",
                style: _questionStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dayButton("월"),
                  _dayButton("화"),
                  _dayButton("수"),
                  _dayButton("목"),
                  _dayButton("금"),
                  _dayButton("토"),
                  _dayButton("일"),
                ],
              ),
              emptyBox(context, 0.05),
              Text(
                "알람음",
                style: _questionStyle,
              ),
              Text(
                "현재 기상나팔만 지원하고 있습니다",
                style: _questionStyle.copyWith(fontSize: garo(context, 0.05)),
              ),
              emptyBox(context, 0.05),
              pmbutton(
                context: context,
                buttonText: "알람 생성",
                onpressed: () async {
                  // Check if at least one day is selected
                  if (selectedDays.isEmpty) {
                    // Show a message or snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("요일을 선택해 주세요")),
                    );
                    return;
                  }

                  // Create an AlarmInfo object with the selected time and days
                  AlarmInfo newAlarm = AlarmInfo(
                    timeOfDay: initialTime,
                    selectedDays: selectedDays,
                    isApproved: false,
                  );

                  alarms.add(newAlarm);

                  // Save the alarm (this could be saved in local storage, shared preferences, or a database)
                  // await saveAlarm(newAlarm); // Assuming `saveAlarm` is a function you've defined

                  // Optionally, show a confirmation message or navigate back
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("알람이 저장되었습니다.")),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => RootTab()),
                        (Route<dynamic> route) => false,  // 로그인 화면을 제거하고 메인 화면으로 이동
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

  String _timeButtonText(TimeOfDay time) {
    String division = (time.hour < 13) ? "오전" : "오후";
    String hour =
    (time.hour < 13) ? time.hour.toString() : (time.hour - 12).toString();
    return division +
        " " +
        hour.padLeft(2, "0") +
        " : " +
        time.minute.toString().padLeft(2, "0");
  }

  Widget _dayButton(String day) {
    bool isSelected = selectedDays.contains(day);

    ButtonStyle _unpick = ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black));
    ButtonStyle _pick = ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white), backgroundColor: WidgetStateProperty.all(Colors.black));

    return Container(
      width: garo(context, 0.1),
      child: TextButton(
        style: (isSelected) ? _pick : _unpick,
        onPressed: () {
          setState(() {
            if (isSelected) {
              selectedDays.remove(day);
            } else {
              selectedDays.add(day);
            }
          });
        },
        child: Text(day),
      ),
    );
  }
}
