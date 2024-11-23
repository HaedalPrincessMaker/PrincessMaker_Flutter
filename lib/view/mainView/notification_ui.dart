import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

import '../../const.dart';

class NotificationUi extends StatefulWidget {
  @override
  State<NotificationUi> createState() => _NotificationUiState();
}

class _NotificationUiState extends State<NotificationUi> {

  @override
  Widget build(BuildContext context) {
    TextStyle _text = TextStyle(
      fontSize: garo(context, 0.05),
      fontFamily: 'Hakgyo',
    );

    return SafeArea(
      child: ListView.builder(
        itemCount: notice.length,
        itemBuilder: (context, index) {
          final notification = notice[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: garo(context, 0.05)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      notification,
                      style: _text,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}