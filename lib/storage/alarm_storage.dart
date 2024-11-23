import 'package:flutter/material.dart';

class AlarmInfo {
  TimeOfDay? timeOfDay;
  List<String>? selectedDays;

  AlarmInfo({
    required TimeOfDay timeOfDay,
    required List<String> selectedDays,
  }) {
    this.timeOfDay = timeOfDay;
    this.selectedDays = selectedDays;
  }
}

List<AlarmInfo> alarms = []; // A list of AlarmInfo objects

