import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../react_size.dart';

Widget pmbutton({
  required BuildContext context,
  required String buttonText,
  required VoidCallback onpressed,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: garo(context, 0.045),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black; // Color when pressed
          } else if (states.contains(WidgetState.disabled)) {
            return Colors.red; // Color when disabled
          }
          return Colors.white; // Default color
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.white; // Color when pressed
          } else if (states.contains(WidgetState.disabled)) {
            return Colors.red; // Color when disabled
          }
          return Colors.black; // Default color
        },
      ),
    ),
    onPressed: onpressed,
    child: Text(
      buttonText,
      style: TextStyle(),
    ),
  );
}
