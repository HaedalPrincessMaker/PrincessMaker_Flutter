import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_princess_maker/view/mainView/alarm_list_ui.dart';
import 'package:flutter_princess_maker/view/mainView/home_ui.dart';
import 'package:flutter_princess_maker/view/mainView/my_profile_ui.dart';
import 'package:flutter_princess_maker/view/mainView/notification_ui.dart';
import 'package:flutter_princess_maker/view/mainView/quiz_ui.dart';
import '../default_layout.dart';

/**
 * RootTab
 * - Main Views들의 기본이 되는 페이지입니다.
 *
 *
 * written by dongsu
 */

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 2;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(() {
      setState(() {
        index = controller.index;
      });
    });

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 5, vsync: this);
    controller.index = 2;
    controller.addListener(() {
      setState(() {
        index = controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle baseTextStyle = TextStyle(
        color: Colors.black,
        fontFamily: 'Gugi',
        fontSize: garo(context, 0.025),
        fontWeight: FontWeight.w500
    );
    IconThemeData baseIconTheme = IconThemeData(
      color: Colors.black,
      size: garo(context, 0.07),
    );
    IconThemeData specialIconTheme = IconThemeData(
      color: Colors.grey[400],
      size: garo(context, 0.07),
    );

    return DefaultLayout(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          AlarmListUi(),
          QuizUi(),
          HomeUi(),
          NotificationUi(),
          MyProfileUi(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: baseTextStyle,
        selectedLabelStyle: baseTextStyle.copyWith(color: Colors.black),
        selectedIconTheme: baseIconTheme.copyWith(color: Colors.black),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            controller.animateTo(index);
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_outlined, ),
            label: '알람',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: '퀴즈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: '마이페이지',
          ),
        ],
        enableFeedback: false,
        selectedItemColor: Colors.black, // 선택된 아이템의 색상 지정
      ),
    );
  }
}