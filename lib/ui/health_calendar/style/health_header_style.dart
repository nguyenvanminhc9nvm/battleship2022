import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthHeaderStyle {
  final bool centerHeaderTitle = false;

  final bool formatButtonVisible = true;

  final bool formatButtonShowNext = true;

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17.0);

  final TextStyle formatButtonTextStyle = const TextStyle();

  final Decoration formatButtonDecoration = const BoxDecoration(
    border: Border(
        top: BorderSide(),
        bottom: BorderSide(),
        left: BorderSide(),
        right: BorderSide()),
    borderRadius: BorderRadius.all(
      Radius.circular(
        12.0,
      ),
    ),
  );

  final EdgeInsets formatButtonPadding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0);

  final Icon pullDownIcon = const Icon(Icons.arrow_drop_down, color: Colors.black, size: 100,);

  /// Icon used for left chevron.
  /// Defaults to black `Icons.chevron_left`.
  final Icon leftChevronIcon =  const Icon(Icons.chevron_left, color: Colors.black);

  /// Icon used for right chevron.
  /// Defaults to black `Icons.chevron_right`.
  final Icon rightChevronIcon = const Icon(Icons.chevron_right, color: Colors.black);
}
