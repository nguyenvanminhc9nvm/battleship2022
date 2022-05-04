//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of table_calendar;

/// Callback exposing currently selected day.
typedef void OnDaySelected(DateTime day, List<DayData> events);

/// Callback exposing currently visible days (first and last of them), as well as current `CalendarFormat`.
typedef void OnVisibleDaysChanged(
    DateTime first, DateTime last, CalendarFormat format);

/// Builder signature for any text that can be localized and formatted with `DateFormat`.
typedef String TextBuilder(DateTime date, dynamic locale);

/// Format to display the `TableCalendar` with.
enum CalendarFormat { month, twoWeeks, week }

/// Available animations to update the `CalendarFormat` with.
enum FormatAnimation { slide, scale }

/// Available day of week formats. `TableCalendar` will start the week with chosen day.
/// * `StartingDayOfWeek.monday`: Monday - Sunday
/// * `StartingDayOfWeek.sunday`: Sunday - Saturday
enum StartingDayOfWeek { monday, sunday }

/// Gestures available to interal `TableCalendar`'s logic.
enum AvailableGestures { none, verticalSwipe, horizontalSwipe, all }

/// Highly customizable, feature-packed Flutter Calendar with gestures, animations and multiple formats.
class TableCalendar extends StatefulWidget {
  final CalendarController calendarController;

  /// Locale to format `TableCalendar` dates with, for example: `'en_US'`.
  ///
  /// If nothing is provided, a default locale will be used.
  final dynamic locale;

  /// Contains a `List` of objects (eg. events) assigned to particular `DateTime`s.
  /// Each `DateTime` inside this `Map` should get its own `List` of above mentioned objects.
  final List<DayData>? events;

  /// `List`s of holidays associated to particular `DateTime`s.
  /// This property allows you to provide custom holiday rules.
  final Map<DateTime, List> holidays;

  /// Called whenever any day gets tapped.
  final OnDaySelected? onDaySelected;

  /// Called whenever any unavailable day gets tapped.
  /// Replaces `onDaySelected` for those days.
  final VoidCallback? onUnavailableDaySelected;

  /// Called whenever the range of visible days changes.
  final OnVisibleDaysChanged? onVisibleDaysChanged;

  /// Initially selected DateTime. Usually it will be `DateTime.now()`.
  /// This property can be used to programmatically select a new date.
  ///
  /// If `TableCalendar` Widget gets rebuilt with a different `selectedDay` than previously,
  /// `onDaySelected` callback will run.
  ///
  /// To animate programmatic selection, use `animateProgSelectedDay` property.
  final DateTime? initialSelectedDay;

  /// The first day of `TableCalendar`.
  /// Days before it will use `unavailableStyle` and run `onUnavailableDaySelected` callback.
  final DateTime? startDay;

  /// The last day of `TableCalendar`.
  /// Days after it will use `unavailableStyle` and run `onUnavailableDaySelected` callback.
  final DateTime? endDay;

  /// `CalendarFormat` which will be displayed first.
  final CalendarFormat initialCalendarFormat;

  /// `Map` of `CalendarFormat`s and `String` names associated with them.
  /// Those `CalendarFormat`s will be used by internal logic to manage displayed format.
  ///
  /// To ensure proper vertical Swipe behavior, `CalendarFormat`s should be in descending order (eg. from biggest to smallest).
  ///
  /// For example:
  /// ```dart
  /// availableCalendarFormats: const {
  ///   CalendarFormat.month: 'Month',
  ///   CalendarFormat.week: 'Week',
  /// }
  /// ```
  final Map<CalendarFormat, String> availableCalendarFormats;

  /// Used to show/hide Header.
  final bool headerVisible;

  /// Used for setting the height of `TableCalendar`'s rows.
  final double? rowHeight;

  /// Animation to run when `CalendarFormat` gets changed.
  final FormatAnimation formatAnimation;

  /// `TableCalendar` will start weeks with provided day.
  /// Use `StartingDayOfWeek.monday` for Monday - Sunday week format.
  /// Use `StartingDayOfWeek.sunday` for Sunday - Saturday week format.
  final StartingDayOfWeek startingDayOfWeek;

  /// `HitTestBehavior` for every day cell inside `TableCalendar`.
  final HitTestBehavior dayHitTestBehavior;

  /// Specify Gestures available to `TableCalendar`.
  /// If `AvailableGestures.none` is used, the Calendar will only be interactive via buttons.
  final AvailableGestures availableGestures;

  /// Configuration for vertical Swipe detector.
  final SimpleSwipeConfig simpleSwipeConfig;

  /// Style for `TableCalendar`'s content.
  final CalendarStyle calendarStyle;

  /// Style for DaysOfWeek displayed between `TableCalendar`'s Header and content.
  final DaysOfWeekStyle daysOfWeekStyle;

  /// Style for `TableCalendar`'s Header.
  final HeaderStyle headerStyle;

  /// Set of Builders for `TableCalendar` to work with.
  final CalendarBuilders builders;

  TableCalendar({
    Key? key,
    required this.calendarController,
    this.locale,
    this.events,
    this.holidays = const {},
    this.onDaySelected,
    this.onUnavailableDaySelected,
    this.onVisibleDaysChanged,
    this.initialSelectedDay,
    this.startDay,
    this.endDay,
    this.initialCalendarFormat = CalendarFormat.month,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    this.headerVisible = true,
    this.rowHeight,
    this.formatAnimation = FormatAnimation.slide,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.calendarStyle = const CalendarStyle(),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.headerStyle = const HeaderStyle(),
    this.builders = const CalendarBuilders(),
  })  : assert(availableCalendarFormats.keys.contains(initialCalendarFormat)),
        assert(availableCalendarFormats.length <= CalendarFormat.values.length),
        super(key: key);

  @override
  _TableCalendarState createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendar>
    with SingleTickerProviderStateMixin {
  DateTime endDayFocusable = DateTime.now();

  @override
  void initState() {
    super.initState();

    widget.calendarController._init(
      events: widget.events,
      holidays: widget.holidays,
      initialDay: widget.initialSelectedDay,
      initialFormat: widget.initialCalendarFormat,
      availableCalendarFormats: widget.availableCalendarFormats,
      useNextCalendarFormat: widget.headerStyle.formatButtonShowsNext,
      startingDayOfWeek: widget.startingDayOfWeek,
      selectedDayCallback: _selectedDayCallback,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      includeInvisibleDays: widget.calendarStyle.outsideDaysVisible,
    );
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null) {
      var eventData = widget.calendarController.visibleEvents
          .where((element) => _isSameDay(element.dateTime, day))
          .toList();
      widget.onDaySelected!(
        day,
        eventData,
      );
    }
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }

  void _selectPrevious() {
    print("pre page ${widget.calendarController._previousFirstDay}");
    setState(() {
      widget.calendarController._selectPrevious();
    });
  }

  void _selectNext() {
    setState(() {
      print("next page ${widget.calendarController._previousLastDay}");
      widget.calendarController._selectNext();
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      widget.calendarController.setSelectedDay(day, isProgrammatic: false);
      _selectedDayCallback(day);
    });
  }

  void _toggleCalendarFormat() {
    setState(() {
      widget.calendarController.toggleCalendarFormat();
    });
  }

  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      // Swipe right
      _selectPrevious();
    } else {
      // Swipe left
      _selectNext();
    }
  }

  void _onUnavailableDaySelected() {
    if (widget.onUnavailableDaySelected != null) {
      widget.onUnavailableDaySelected!();
    }
  }

  bool _isDayUnavailable(DateTime day) {
    return (widget.startDay != null && day.isBefore(widget.startDay!)) ||
        (widget.endDay != null && day.isAfter(widget.endDay!));
  }

  DayData? _getEventDay(DateTime day) {
    return widget.calendarController.visibleEvents.firstWhereOrNull(
        (it) => widget.calendarController._isSameDay(it.dateTime, day));
  }

  DateTime? _getHolidayKey(DateTime day) {
    return widget.calendarController.visibleHolidays.keys.firstWhereOrNull(
        (it) => widget.calendarController._isSameDay(it, day));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (widget.headerVisible) {
      children.addAll([
        const SizedBox(height: 6.0),
        _buildHeader(),
      ]);
    }

    children.addAll([
      const SizedBox(height: 10.0),
      _buildCalendarContent(),
      const SizedBox(height: 4.0),
    ]);

    return ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildHeader() {
    final children = [
      _CustomIconButton(
        icon: widget.headerStyle.leftChevronIcon,
        onTap: _selectPrevious,
        margin: widget.headerStyle.leftChevronMargin,
        padding: widget.headerStyle.leftChevronPadding,
        disable: false,
      ),
      Expanded(
        child: Text(
          widget.headerStyle.titleTextBuilder != null
              ? widget.headerStyle.titleTextBuilder!(
                  widget.calendarController.focusedDay, widget.locale)
              : DateFormat.yMMMM(widget.locale)
                  .format(widget.calendarController.focusedDay),
          style: widget.headerStyle.titleTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      _CustomIconButton(
        icon: widget.headerStyle.rightChevronIcon,
        onTap: _selectNext,
        margin: widget.headerStyle.rightChevronMargin,
        padding: widget.headerStyle.rightChevronPadding,
        disable: endDayFocusable.compareTo(DateTime.now()) == 1,
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

  Widget _buildFormatButton() {
    return GestureDetector(
      onTap: _toggleCalendarFormat,
      child: Container(
        decoration: widget.headerStyle.formatButtonDecoration,
        padding: widget.headerStyle.formatButtonPadding,
        child: Text(
          widget.calendarController._getFormatButtonText() ?? "",
          style: widget.headerStyle.formatButtonTextStyle,
        ),
      ),
    );
  }

  Widget _buildCalendarContent() {
    if (widget.formatAnimation == FormatAnimation.slide) {
      return AnimatedSize(
        duration: Duration(
          milliseconds:
              widget.calendarController.calendarFormat == CalendarFormat.month
                  ? 330
                  : 220,
        ),
        curve: Curves.fastOutSlowIn,
        alignment: const Alignment(0, -1),
        child: _buildWrapper(),
      );
    } else {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: _buildWrapper(
          key: ValueKey(widget.calendarController.calendarFormat),
        ),
      );
    }
  }

  Widget _buildWrapper({Key? key}) {
    Widget wrappedChild = _buildTable();

    switch (widget.availableGestures) {
      case AvailableGestures.all:
        wrappedChild = _buildVerticalSwipeWrapper(
          _buildHorizontalSwipeWrapper(
            wrappedChild,
          ),
        );
        break;
      case AvailableGestures.verticalSwipe:
        wrappedChild = _buildVerticalSwipeWrapper(
          wrappedChild,
        );
        break;
      case AvailableGestures.horizontalSwipe:
        wrappedChild = _buildHorizontalSwipeWrapper(
          wrappedChild,
        );
        break;
      case AvailableGestures.none:
        break;
    }

    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: wrappedChild,
    );
  }

  Widget _buildVerticalSwipeWrapper(Widget child) {
    return SimpleGestureDetector(
      child: child,
      onVerticalSwipe: (direction) {
        setState(() {
          widget.calendarController
              .swipeCalendarFormat(isSwipeUp: direction == SwipeDirection.up);
        });
      },
      swipeConfig: widget.simpleSwipeConfig,
    );
  }

  Widget _buildHorizontalSwipeWrapper(Widget child) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.decelerate,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(widget.calendarController._dx, 0),
                  end: const Offset(0, 0))
              .animate(animation),
          child: child,
        );
      },
      layoutBuilder: (currentChild, _) => currentChild ?? Container(),
      child: Dismissible(
        key: ValueKey(widget.calendarController._pageId),
        resizeDuration: null,
        onDismissed: _onHorizontalSwipe,
        direction: DismissDirection.horizontal,
        child: child,
      ),
    );
  }

  ///set list data
  Widget _buildTable() {
    const daysInWeek = 7;
    final children = <TableRow>[
      _buildDaysOfWeek(),
    ];

    int x = 0;
    while (x < widget.calendarController._visibleDays.value.length) {
      children.add(_buildTableRow(widget.calendarController._visibleDays.value
          .skip(x)
          .take(daysInWeek)
          .toList()));
      x += daysInWeek;
    }

    return Table(
      border: const TableBorder(
        bottom: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
        horizontalInside: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      // Makes this Table fill its parent horizontally
      defaultColumnWidth: const FractionColumnWidth(1.0 / daysInWeek),
      children: children,
    );
  }

  TableRow _buildDaysOfWeek() {
    return TableRow(
      children:
          widget.calendarController._visibleDays.value.take(7).map((date) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              widget.daysOfWeekStyle.dowTextBuilder != null
                  ? widget.daysOfWeekStyle.dowTextBuilder!(date, widget.locale)
                  : DateFormat.E(widget.locale).format(date),
              style: widget.calendarController._isWeekend(date)
                  ? widget.daysOfWeekStyle.weekendStyle
                  : widget.daysOfWeekStyle.weekdayStyle,
            ),
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<DateTime> days) {
    //map days to dayDatas
    return TableRow(
        children: days.map((date) => _buildTableCell(date)).toList());
  }

  // TableCell will have equal width and height
  Widget _buildTableCell(DateTime date) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.rowHeight ?? constraints.maxWidth,
          minHeight: widget.rowHeight ?? constraints.maxWidth,
        ),
        child: _buildCell(date),
      ),
    );
  }

  Widget _buildCell(DateTime date) {
    Widget content = _buildCellContent(date);

    final eventKey = _getEventDay(date);
    final holidayKey = _getHolidayKey(date);
    final key = eventKey ?? holidayKey;

    Widget eventWidget =
        eventKey != null ? _buildEventWidgetType(eventKey) : const Text("");
    if (key != null) {
      final children = <Widget>[content];
      if (!_isDayUnavailable(date)) {
        children.add(eventWidget);
        children.add(
          Positioned(
            top: widget.calendarStyle.markersPositionTop,
            bottom: widget.calendarStyle.markersPositionBottom,
            left: widget.calendarStyle.markersPositionLeft,
            right: widget.calendarStyle.markersPositionRight,
            child: Container(
              width: 4.0,
              height: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 0.3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
        );
      }

      if (children.length > 1) {
        content = Stack(
          alignment: widget.calendarStyle.markersAlignment,
          children: children,
        );
      }
    }

    return GestureDetector(
      behavior: widget.dayHitTestBehavior,
      onTap: () => _isDayUnavailable(date)
          ? _onUnavailableDaySelected()
          : _selectDay(date),
      child: content,
    );
  }

  Widget _buildEventWidgetType(DayData data) {
    return Positioned(
      child: SizedBox(
        width: 20,
        height: 20,
        child: SvgPicture.asset(data.dayType),
      ),
    );
  }

  Widget _buildCellContent(DateTime date) {
    final tIsUnavailable = _isDayUnavailable(date);
    final tIsSelected = widget.calendarController.isSelected(date);
    final tIsToday = widget.calendarController.isToday(date);
    final tIsOutside = widget.calendarController._isExtraDay(date);
    final tIsHoliday = widget.calendarController.visibleHolidays
        .containsKey(_getHolidayKey(date));
    final tIsWeekend = widget.calendarController._isWeekend(date);
    return _CellWidget(
      text: '${date.day}',
      isUnavailable: tIsUnavailable,
      isSelected: tIsSelected,
      isToday: tIsToday,
      isWeekend: tIsWeekend,
      isOutsideMonth: tIsOutside,
      isHoliday: tIsHoliday,
      calendarStyle: widget.calendarStyle,
    );
  }

  Widget _buildMarker(DateTime? date, dynamic event) {
    if (widget.builders.singleMarkerBuilder != null && date != null) {
      return widget.builders.singleMarkerBuilder!(context, date, event);
    } else {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 0.3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.calendarStyle.markersColor,
        ),
      );
    }
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

