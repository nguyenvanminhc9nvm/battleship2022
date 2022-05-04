import 'package:battleship2022/ui/health_calendar/model/health_data.dart';
import 'package:battleship2022/ui/health_calendar/style/health_calendar_style.dart';
import 'package:battleship2022/ui/health_calendar/style/health_day_of_week_style.dart';
import 'package:battleship2022/ui/health_calendar/style/health_header_style.dart';
import 'package:battleship2022/ui/health_calendar/widgets/health_calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

typedef DidSelectedDay = void Function(
    DateTime dateTime, FiguresHealthData data);

typedef VisibleDayChanged = void Function(DateTime first, DateTime last);

enum FormatAnimation { slide, scale }

enum StartingDayOfWeek { monday, sunday }

enum AvailableGestures { non, vertical, horizontal, all }

class HealthCalendarWidget extends StatefulWidget {
  final HealthCalendarController controller;

  final dynamic locale;

  final List<HealthData>? healthEvent;

  final DidSelectedDay? didSelectedDay;

  final VoidCallback? onUnavailableDaySelected;

  final VisibleDayChanged? visibleDayChanged;

  final DateTime? initialSelectedDay;

  final DateTime? startDay;

  final DateTime? endDay;

  final bool headerVisible;

  final double? rowHeight;

  final FormatAnimation formatAnimation;

  final StartingDayOfWeek startingDayOfWeek;

  final HitTestBehavior dayHitTestBehavior;

  final AvailableGestures availableGestures;

  const HealthCalendarWidget({
    Key? key,
    required this.controller,
    this.locale,
    this.healthEvent,
    this.didSelectedDay,
    this.onUnavailableDaySelected,
    this.visibleDayChanged,
    this.initialSelectedDay,
    this.startDay,
    this.endDay,
    this.headerVisible = true,
    this.rowHeight,
    this.formatAnimation = FormatAnimation.slide,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.availableGestures = AvailableGestures.all,
  }) : super(key: key);

  @override
  State<HealthCalendarWidget> createState() => _HealthCalendarWidgetState();
}

class _HealthCalendarWidgetState extends State<HealthCalendarWidget> {
  final HealthCalendarStyle calendarStyle = HealthCalendarStyle();

  final HealthDayOfWeekStyle dayOfWeekStyle = HealthDayOfWeekStyle();

  final HealthHeaderStyle headerStyle = HealthHeaderStyle();

  @override
  void initState() {
    widget.controller.init(
      startingDayOfWeek: widget.startingDayOfWeek,
      visibleDayChanged: widget.visibleDayChanged,
      includeInvisibleDays: calendarStyle.outsideDaysVisible,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
