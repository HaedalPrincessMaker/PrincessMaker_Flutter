import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Frame extends ConsumerStatefulWidget {
  Widget child;
  BottomNavigationBar? bottomNavigationBar;

  Frame({
    required this.child,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  ConsumerState<Frame> createState() => _FrameState();
}

class _FrameState extends ConsumerState<Frame>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        scrolledUnderElevation: 0, // 스크롤시 앱바 그림자 제거
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'asset/image/dozzari_tumyeong_logo.png',
              height: garo(context, 0.0275),
            ),
          ],
        ),
        centerTitle: true, //Row와 함께 이용하여 Ttile 가운데 정렬
      ),
      bottomNavigationBar: (widget.bottomNavigationBar != null)
          ? widget.bottomNavigationBar
          : null,
      body: widget.child,
    );
  }
}
