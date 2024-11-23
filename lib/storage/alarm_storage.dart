import 'package:flutter/material.dart';

class AlarmInfo {
  TimeOfDay? timeOfDay;
  List<String>? selectedDays;
  bool isApproved = true;

  AlarmInfo({
    required TimeOfDay timeOfDay,
    required List<String> selectedDays,
    required bool isApproved,
  }) {
    this.timeOfDay = timeOfDay;
    this.selectedDays = selectedDays;
    this.isApproved = isApproved;
  }
}

List<AlarmInfo> alarms = []; // A list of AlarmInfo objects

