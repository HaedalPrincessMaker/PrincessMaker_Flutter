import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AlarmExample extends StatelessWidget {
  Future<void> copyAssetToLocal(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    print("파일이 로컬에 복사되었습니다: ${file.path}");
  }

  Future<void> setAlarm() async {
    // assets에서 로컬로 오디오 파일 복사
    await copyAssetToLocal('asset/music/army.mp3', 'army.mp3');

    final alarmSettings = AlarmSettings(
      id: 1,
      dateTime: DateTime.now().add(Duration(seconds: 3)),
      assetAudioPath: '${(await getApplicationDocumentsDirectory()).path}/army.mp3', // 로컬 파일 경로 사용
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
    print("알람이 설정되었습니다.");
  }

  Future<void> stopAlarm() async {
    await Alarm.stopAll(); // 알람 ID 1을 멈춤
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarm Example")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: setAlarm,
              child: Text("알람 설정하기"),
            ),
            ElevatedButton(
              onPressed: stopAlarm,
              child: Text("알람 멈추기"),
            ),
          ],
        ),
      ),
    );
  }
}
