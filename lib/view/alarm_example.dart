import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../storage/alarm_storage.dart';

class AlarmExample {
  Future<void> copyAssetToLocal(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final file =
        File('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    print("파일이 로컬에 복사되었습니다: ${file.path}");
  }

  Future<void> setWeeklyAlarm({
    required TimeOfDay timeOfDay,
    required List<String> selectedDays,
  }) async {
    const dayMap = {
      "월": DateTime.monday,
      "화": DateTime.tuesday,
      "수": DateTime.wednesday,
      "목": DateTime.thursday,
      "금": DateTime.friday,
      "토": DateTime.saturday,
      "일": DateTime.sunday,
    };

    for (String day in selectedDays) {
      if (dayMap.containsKey(day)) {
        final int dayOfWeek = dayMap[day]!;

        DateTime now = DateTime.now();
        DateTime alarmDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );

        while (
            alarmDateTime.weekday != dayOfWeek || alarmDateTime.isBefore(now)) {
          alarmDateTime = alarmDateTime.add(Duration(days: 1));
        }

        await copyAssetToLocal('asset/music/army.mp3', 'army.mp3');

        final alarmSettings = AlarmSettings(
          id: (alarmDateTime.millisecondsSinceEpoch % 2147483647).toInt(),
          dateTime: alarmDateTime,
          assetAudioPath:
              '${(await getApplicationDocumentsDirectory()).path}/army.mp3',
          loopAudio: true,
          vibrate: false,
          volume: 0.1,
          fadeDuration: 3.0,
          androidFullScreenIntent: true,
          notificationSettings: const NotificationSettings(
            title: 'Wake Up!',
            body: 'Your alarm is ringing!',
            stopButton: 'Stop',
            icon: 'notification_icon',
          ),
        );

        await Alarm.set(alarmSettings: alarmSettings);
        print("알람 설정 완료: $alarmDateTime ($day)");
      }
    }
  }

  // 전체 알람 종료 함수
  Future<void> cancelAllAlarms() async {
    List<AlarmInfo> tempAlarms = alarms;
    // 모든 알람 취소
    for(AlarmInfo alarm in tempAlarms) {
      await Alarm.stopAll();
    }
    await Alarm.stopAll();
    print("모든 알람이 종료되었습니다.");
  }

  static late SharedPreferences prefs;

  Future<void> saveAlarm(AlarmInfo alarm) async {
    prefs = await SharedPreferences.getInstance();

    List<String> days = alarm.selectedDays!;
    String timeString = "${alarm.timeOfDay!.hour}:${alarm.timeOfDay!.minute}";

    await prefs.setStringList('alarm_days', days);
    await prefs.setString('alarm_time', timeString);
  }

  Widget getCancleButton() {
    return ElevatedButton(
      onPressed: () async {
        Future.delayed(Duration(seconds: 5));
        cancelAllAlarms();
      },
      child: Text("알람종료"),
    );
  }
}