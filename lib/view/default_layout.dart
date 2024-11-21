import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/text_widget/logo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * 주요 화면에서 사용될 기본 레이아웃 파일
 *
 *  - 상단 로고만 기본으로 정의해놓았습니다.
 *
 * @param buttomNavigationBar -> nullable -> 하단 네비게이션 바.
 * @param child -> 화면에 표시될 위젯
 *
 * written by: dongsu
 */

class DefaultLayout extends ConsumerStatefulWidget {
  Widget child;
  BottomNavigationBar? bottomNavigationBar;

  DefaultLayout({
    required this.child,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0, // 스크롤시 앱바 그림자 제거
        title: getLogo(context: context, width: 0.075),
        centerTitle: true, //Row와 함께 이용하여 Ttile 가운데 정렬
      ),
      bottomNavigationBar: (widget.bottomNavigationBar != null)
          ? widget.bottomNavigationBar
          : null,
      body: widget.child,
    );
  }
}