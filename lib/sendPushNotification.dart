import 'package:dio/dio.dart';
import 'package:flutter_princess_maker/const.dart';

Future<void> sendPushNotification(String token, String title, String body) async {
  final dio = Dio();

  try {
    final response = await dio.post(
      '$myserver/api/notifications/send', // Spring 서버의 URL
      data: {
        'token': token,
        'title': title,
        'body': body,
      },
    );

    if (response.statusCode == 200) {
      print('푸시 알림 요청 성공');
    } else {
      print('푸시 알림 요청 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('에러 발생: $e');
  }
}
