import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pmbutton({
  required BuildContext context,
  required String buttonText,
  required VoidCallback onpressed,

}) {
  return ElevatedButton(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 18,
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
