import 'package:battleship2022/ui/health_calendar/widgets/health_calendar_widget.dart';
import 'package:flutter/cupertino.dart';

import '../model/health_data.dart';

typedef DidSelectedDayCallBack = void Function(DateTime dateTime);
const double _dxMax = 1.2;
const double _dxMin = -1.2;

class HealthCalendarController {
  DateTime get focusedDay => _focusDay;

  DateTime get selectedDay => _selectedDay;

  List<DateTime> get visibleDays =>
      _includeInvisibleDays ? _visibleDays.value : _visibleDays.value.where((day) => !_isExtraDay(day)).toList();

  List<HealthData> get visibleEvents =>
      _healthEvents.where((entry) =>
          visibleDays.any((element) => _isSameDay(element, entry.dateTime))
      ).toList();

  late DateTime _focusDay;
  late DateTime _selectedDay;
  late StartingDayOfWeek _startingDayOfWeek;
  late ValueNotifier<List<DateTime>> _visibleDays;
  late DateTime _previousFirstDay;
  late DateTime _previousLastDay;
  late int _pageId;
  late double _dx;
  late bool _includeInvisibleDays;
  late DidSelectedDayCallBack? _didSelectedDayCallBack;
  late List<HealthData> _healthEvents;

  void init({
  List<HealthData>? healthEvents,
    DateTime? initialDay,
    required StartingDayOfWeek startingDayOfWeek,
    DidSelectedDayCallBack? dayCallBack,
    VisibleDayChanged? visibleDayChanged,
    required bool includeInvisibleDays,
  }) {
    _healthEvents = healthEvents ?? [];
    _startingDayOfWeek = startingDayOfWeek;
    _didSelectedDayCallBack = dayCallBack;
    _includeInvisibleDays = includeInvisibleDays;

    _pageId = 0;
    _dx = 0;

    final now = DateTime.now();

    _focusDay = initialDay ?? DateTime(now.year, now.month, now.day);
    _selectedDay = _focusDay;
    _visibleDays = ValueNotifier(_getVisibleDays());
    _previousFirstDay = _visibleDays.value.first;
    _previousLastDay = _visibleDays.value.last;

    _visibleDays.addListener(() {
      if (!_isSameDay(_visibleDays.value.first, _previousFirstDay) ||
          !_isSameDay(_visibleDays.value.last, _previousLastDay)) {
        _previousFirstDay = _visibleDays.value.first;
        _previousLastDay = _visibleDays.value.last;
        if (visibleDayChanged != null) {
          visibleDayChanged(
            _getFirstDay(includeInvisible: _includeInvisibleDays),
            _getLastDay(includeInvisible: _includeInvisibleDays),
          );
        }
      }
    });
  }

  DateTime _getFirstDay({required bool includeInvisible}) {
    if (!includeInvisible) {
      return _firstDayOfMonth(_focusDay);
    } else {
      return _visibleDays.value.first;
    }
  }

  DateTime _getLastDay({required bool includeInvisible}) {
    if (!includeInvisible) {
      return _lastDayOfMonth(_focusDay);
    } else {
      return _visibleDays.value.last;
    }
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date =
    month.month < 12 ? DateTime.utc(month.year, month.month + 1, 1, 12) : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }

  List<DateTime> _getVisibleDays() {
    return _daysInWeek(_focusDay)
      ..addAll(_daysInWeek(
        _focusDay.add(const Duration(days: 7)),
      ));
  }

  List<DateTime> _daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    return _daysInRange(first, last).toList();
  }

  Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
    var temp = firstDay;

    while (temp.isBefore(lastDay)) {
      yield DateTime.utc(temp.year, temp.month, temp.day, 12);
      temp = temp.add(const Duration(days: 1));
    }
  }

  DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final decreaseNum = _startingDayOfWeek == StartingDayOfWeek.sunday ? day.weekday % 7 : day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final increaseNum = _startingDayOfWeek == StartingDayOfWeek.sunday ? day.weekday % 7 : day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
  }

  void dispose() {
    _visibleDays.dispose();
  }

  void setSelectedDay(
      DateTime value, {
        bool isProgrammatic = true,
        bool animate = true,
        bool runCallback = false,
      }) {
    if (animate) {
      if (value.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (value.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }

    _selectedDay = value;
    _focusDay = value;
    _updateVisibleDays(isProgrammatic);

    if (_didSelectedDayCallBack != null && isProgrammatic && runCallback) {
      _didSelectedDayCallBack!(value);
    }
  }

  void _updateVisibleDays(bool isProgrammatic) {
    if (isProgrammatic) {
      _visibleDays.value = _getVisibleDays();
    }
  }

  void _decrementPage() {
    _pageId--;
    _dx = _dxMin;
  }

  void _incrementPage() {
    _pageId++;
    _dx = _dxMax;
  }

  void _selectPrevious() {
      _selectPreviousMonth();


    _visibleDays.value = _getVisibleDays();
    _decrementPage();
  }

  void _selectNext() {
      _selectNextMonth();

    _visibleDays.value = _getVisibleDays();
    _incrementPage();
  }

  void _selectPreviousMonth() {
    _focusDay = _previousMonth(_focusDay);
  }

  void _selectNextMonth() {
    _focusDay = _nextMonth(_focusDay);
  }

  DateTime _previousMonth(DateTime month) {
    if (month.month == 1) {
      return DateTime(month.year - 1, 12);
    } else {
      return DateTime(month.year, month.month - 1);
    }
  }

  DateTime _nextMonth(DateTime month) {
    if (month.month == 12) {
      return DateTime(month.year + 1, 1);
    } else {
      return DateTime(month.year, month.month + 1);
    }
  }

  bool isSelected(DateTime day) {
    return _isSameDay(day, _selectedDay);
  }

  /// Returns true if `day` is the same day as `DateTime.now()`.
  bool isToday(DateTime day) {
    return _isSameDay(day, DateTime.now());
  }

  bool _isExtraDay(DateTime day) {
    return _isExtraDayBefore(day) || _isExtraDayAfter(day);
  }

  bool _isExtraDayBefore(DateTime day) {
    return day.month < _focusDay.month;
  }

  bool _isExtraDayAfter(DateTime day) {
    return day.month > _focusDay.month;
  }
}