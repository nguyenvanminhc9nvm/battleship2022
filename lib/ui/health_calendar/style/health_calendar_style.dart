import 'package:flutter/material.dart';

class HealthCalendarStyle {
  final TextStyle weekdayStyle = const TextStyle();

  final TextStyle weekendStyle = const TextStyle(color:  Color(0xFFF44336));

  final TextStyle selectedStyle = const TextStyle(color:  Colors.black, fontSize: 16.0);

  final TextStyle todayStyle = const TextStyle(color:  Colors.black, fontSize: 16.0);

  final TextStyle outsideStyle = const TextStyle(color:  Color(0xFF9E9E9E));

  final TextStyle outsideWeekendStyle = const TextStyle(color:  Color(0xFFEF9A9A));

  final TextStyle unavailableStyle = const TextStyle(color:  Color(0xFFBFBFBF));

  final Color todayColor = const Color(0xFF9FA8DA);

  final Color selectedColor = const Color(0xFF5C6BC0);

  final Color markersColors = Colors.red;

  final Alignment markersAlignment = Alignment.bottomCenter;

  final int markersMaxAmount = 4;

  final bool outsideDaysVisible = true;

  final bool renderSelectedFirst = true;

  final bool canEventMarkersOverflow = false;
}
