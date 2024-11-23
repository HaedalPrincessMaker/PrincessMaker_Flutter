import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../storage/alarm_storage.dart';

class AlarmExample {
  Future<void> copyAssetToLocal(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    print("파일이 로컬에 복사되었습니다: ${file.path}");
  }

  Future<void> setWeeklyAlarm({
    required TimeOfDay timeOfDay,
    required List<String> selectedDays,
  }) async {
    // 요일 매핑 (Flutter의 DateTime은 월요일이 1, 일요일이 7)
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

        // 현재 시간 기준으로 해당 요일의 날짜 계산
        DateTime now = DateTime.now();
        DateTime alarmDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );

        // 다음 해당 요일로 이동
        while (alarmDateTime.weekday != dayOfWeek || alarmDateTime.isBefore(now)) {
          alarmDateTime = alarmDateTime.add(Duration(days: 1));
        }

        // 로컬 파일 복사
        await copyAssetToLocal('asset/music/army.mp3', 'army.mp3');

        final alarmSettings = AlarmSettings(
          id:  (alarmDateTime.millisecondsSinceEpoch % 2147483647).toInt(),// 고유 ID로 설정
          dateTime: alarmDateTime,
          assetAudioPath: '${(await getApplicationDocumentsDirectory()).path}/army.mp3',
          loopAudio: true,
          vibrate: false,
          volume: 0.8,
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

  Future<void> saveAlarm(AlarmInfo alarm) async {
    final prefs = await SharedPreferences.getInstance();

    // You can save the alarm info as a string or in any format you prefer
    // Here's a simple example saving the time and selected days
    List<String> days = alarm.selectedDays!;
    String timeString = "${alarm.timeOfDay!.hour}:${alarm.timeOfDay!.minute}";

    // Save the alarm info in SharedPreferences
    await prefs.setStringList('alarm_days', days);
    await prefs.setString('alarm_time', timeString);
  }
}
