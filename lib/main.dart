import 'dart:io';

import 'package:alarm/alarm.dart' as alarm;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_princess_maker/secret/app_key.dart';
import 'package:flutter_princess_maker/storage/alarm_storage.dart';
import 'package:flutter_princess_maker/storage/pm_storage.dart';
import 'package:flutter_princess_maker/view/login/login_register.dart';
import 'package:flutter_princess_maker/view/mainView/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';

import 'const.dart';

void main() async {
  // Ensure Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "AIzaSyAYVV1TanixYhMgtKyB_4HZLzC1gKON6ec",
    appId: "1:173347122669:android:937f5954397d7086b2cbe4",
    messagingSenderId: "173347122669",
    projectId: "princess-maker-firebase",
    storageBucket: "princess-maker-firebase.firebasestorage.app",
  ));

  // Initialize Firebase Messaging
  FirebaseMessaging fbMsg = FirebaseMessaging.instance;

  // Get FCM token
  String? fcmToken =
  await fbMsg.getToken(vapidKey: "BGRA_GV..........keyvalue");
  print("FCM Token: $fcmToken");
  storage["fcm"] = fcmToken!;

  // TODO: Store FCM token to your server

  // Set up FCM token refresh handling
  fbMsg.onTokenRefresh.listen((newToken) {
    print("Token Refreshed: $newToken");
    // TODO: Store refreshed token to your server
  });

  // Initialize Alarm plugin
  await alarm.Alarm.init();

  // Initialize Kakao SDK
  KakaoSdk.init(
    nativeAppKey: '${NATIVE_APP_KEY}', // Replace with your Kakao app key
  );

  // Run your app with ProviderScope
  runApp(ProviderScope(child: MyApp()));

  // Local Notification Plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Platform-specific configuration for notifications (only Android)
  if (Platform.isAndroid) {
    const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
      'important_channel', // Channel ID
      'Important Notifications', // Channel Name
      importance: Importance.high,
    );

    // Initialize notification plugin with Android specific settings
    final AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Create Notification Channel on Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  // Background message handler
  FirebaseMessaging.onBackgroundMessage(fbMsgBackgroundHandler);

  // Foreground message handler
  FirebaseMessaging.onMessage.listen((message) {
    fbMsgForegroundHandler(
      message,
      flutterLocalNotificationsPlugin,
    );
  });

  // Set up message click event handling
  await setupInteractedMessage(fbMsg);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR', // Customize your font family
      ),
      home: (storage.containsKey("userId")) ? RootTab() : LoginRegister(),
      // home: RootTab()
    );
  }
}

// Firebase Background Messaging Handler
Future<void> fbMsgBackgroundHandler(RemoteMessage message) async {
  print("[FCM - Background] MESSAGE : ${message.messageId}");
  saveMessage(message);

  if (message.notification != null) {
    saveMessage(message);
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');

    // Show notification in the foreground
  }
  // Handle background message
}

// Firebase Foreground Messaging Handler
Future<void> fbMsgForegroundHandler(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    ) async {
  print('[FCM - Foreground] MESSAGE : ${message.notification}');

  if (message.notification != null) {
    saveMessage(message);
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');

    // Show notification in the foreground
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'important_channel', // Channel ID
          'Important Notifications', // Channel Name
          icon: '@mipmap/ic_launcher', // Icon for notification
        ),
      ),
    );
  }
}

// FCM Message Click Event Handler
Future<void> setupInteractedMessage(FirebaseMessaging fbMsg) async {
  RemoteMessage? initialMessage = await fbMsg.getInitialMessage();
  // Handle message if app was terminated and opened through notification
  if (initialMessage != null) clickMessageEvent(initialMessage);

  // Handle message if app was in background and opened through notification
  FirebaseMessaging.onMessageOpenedApp.listen(clickMessageEvent);
}

void clickMessageEvent(RemoteMessage message) {
  // Handle click event when the user taps on a notification
  print('Notification clicked! Data: ${message.data}');
  // Example: Navigate based on the message data
  // Navigator.pushNamed(context, '/specificPage', arguments: message.data);
}

void saveMessage(RemoteMessage message) {
  if (message.notification != null) {
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');
    print("get message title : ${message.notification?.title}");
    if((message.notification?.title)!.contains("승인완료")) {
      alarms.forEach((alarm) => alarm.isApproved = true);
    }

    notice.add('${message.notification?.title} : ${message.notification?.body}');

    Fluttertoast.showToast(msg: '${message.notification?.title} : ${message.notification?.body}', gravity: ToastGravity.CENTER);
    // Show notification in the foregrou
  }
}
