import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/text_widget/logo.dart';

class RegisterFrame extends ConsumerStatefulWidget {
  Widget child;

  RegisterFrame({
    required this.child,
    super.key,
  });

  @override
  ConsumerState<RegisterFrame> createState() => _FrameState();
}

class _FrameState extends ConsumerState<RegisterFrame>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: getLogo(context: context, width: 0.065),
        centerTitle: true, //Row와 함께 이용하여 Ttile 가운데 정렬
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: widget.child,
        ),
      ),
    );
  }
}
