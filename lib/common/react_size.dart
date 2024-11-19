import 'package:flutter/material.dart';

/**
 * 화면의 가로, 세로 비율을 계산하여 반환하는 함수 garo, sero
 *
 * @param context -> BuildContext -> 화면의 context
 * @param width or height -> double -> 화면 가로 비율
 *
 * @return -> double -> 화면 가로 혹은 세로 비율에 따른 값
 */

double garo(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

double sero(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}