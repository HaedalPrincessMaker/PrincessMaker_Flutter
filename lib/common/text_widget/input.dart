import 'package:flutter/material.dart';

TextFormField textInputBox(
    {required BuildContext context,
    required TextEditingController controller,
      required GestureTapCallback onTap,
      required ValueChanged<String> onChanged,
    required String hintText,
    required double fontSize}) {
  return TextFormField(
    onChanged: onChanged,
    onTap: onTap,
    scrollPadding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    controller: controller,
    style: TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(fontFamily: 'Hakgyo', fontWeight: FontWeight.normal),
    ),
  );
}
