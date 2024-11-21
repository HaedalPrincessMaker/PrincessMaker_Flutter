import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/button/pmbutton.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/view/default_layout.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  TimeOfDay initialTime = TimeOfDay.now();

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
              TextButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.black)),
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
                  style: _questionStyle,
                ),
              ),
              Text(
                "요일 설정",
                style: _questionStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dayButtion("월"),
                  _dayButtion("화"),
                  _dayButtion("수"),
                  _dayButtion("목"),
                  _dayButtion("금"),
                  _dayButtion("토"),
                  _dayButtion("일"),
                ],
              ),
              Text(
                "알람음 설정",
                style: _questionStyle,
              ),
              pmbutton(
                context: context,
                buttonText: "친구에게 승인 요청",
                onpressed: () => print("승인 요청 버튼 클릭"),
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

  Widget _dayButtion(String day) {
    return Container(
      width: garo(context, 0.1),
      child: TextButton(
        style:
            ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
        onPressed: () => print('select : $day'),
        child: Text(day),
      ),
    );
  }
}
