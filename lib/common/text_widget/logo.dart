import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

Widget getLogo({required BuildContext context, required double width}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: garo(context, 0.01)),
    child: Text(
      "일나람",
      style: TextStyle(
        fontFamily: 'Gugi',
        fontSize: garo(context, width),
        color: Colors.black,
      ),
    ),
  );
}