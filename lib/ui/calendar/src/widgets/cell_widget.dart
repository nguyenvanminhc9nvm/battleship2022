//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of table_calendar;

class _CellWidget extends StatelessWidget {
  final String text;
  final bool isUnavailable;
  final bool isSelected;
  final bool isToday;
  final bool isWeekend;
  final bool isOutsideMonth;
  final bool isHoliday;
  final CalendarStyle calendarStyle;

  const _CellWidget({
    Key? key,
    required this.text,
    this.isUnavailable = false,
    this.isSelected = false,
    this.isToday = false,
    this.isWeekend = false,
    this.isOutsideMonth = false,
    this.isHoliday = false,
    required this.calendarStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: _buildCellDecoration(),
      margin: const EdgeInsets.all(6.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            text,
            style: _buildCellTextStyle(),
          ),
        ],
      ),
    );
  }

  Decoration _buildCellDecoration() {
    if (isSelected && calendarStyle.renderSelectedFirst) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.2),
      );
    } else if (isToday) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.2),
      );
    } else if (isSelected) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.2),
      );
    } else {
      return const BoxDecoration();
    }
  }

  TextStyle _buildCellTextStyle() {
    if (isUnavailable) {
      return calendarStyle.unavailableStyle;
    } else if (isSelected && calendarStyle.renderSelectedFirst) {
      return calendarStyle.selectedStyle;
    } else if (isToday) {
      return calendarStyle.todayStyle;
    } else if (isSelected) {
      return calendarStyle.selectedStyle;
    } else if (isOutsideMonth && isHoliday) {
      return calendarStyle.outsideHolidayStyle;
    } else if (isHoliday) {
      return calendarStyle.holidayStyle;
    } else if (isOutsideMonth && isWeekend) {
      return calendarStyle.outsideWeekendStyle;
    } else if (isOutsideMonth) {
      return calendarStyle.outsideStyle;
    } else if (isWeekend) {
      return calendarStyle.weekendStyle;
    } else {
      return calendarStyle.weekdayStyle;
    }
  }
}
