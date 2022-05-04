import 'package:battleship2022/ui/calendar/chart_calendar/calendar_horizontal_widget.dart';
import 'package:battleship2022/ui/calendar/model/day_data.dart';
import 'package:battleship2022/ui/calendar/table_calendar.dart';
import 'package:battleship2022/utils/constant/constant.dart';
import 'package:flutter/material.dart';

class CalendarCustomScreen extends StatefulWidget {
  const CalendarCustomScreen({Key? key}) : super(key: key);

  @override
  State<CalendarCustomScreen> createState() => _CalendarCustomScreenState();
}

class _CalendarCustomScreenState extends State<CalendarCustomScreen>
    with TickerProviderStateMixin {
  final List<DayData> _events = [
    DayData(DateTime(2022, 04, 21), ImageConst.icMap55, 1, [
      EventData("2022-01-01 08:12:00", ImageConst.icMap35, 1, "140"),
      EventData("2022-01-01 08:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 09:30:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 09:46:00", ImageConst.icMap55, 1, "140"),
       EventData("2022-01-01 10:29:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 11:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 12:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 13:14:00", ImageConst.icMap55, 1, "140"),
       EventData("2022-01-01 14:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 15:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 16:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 17:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 18:14:00", ImageConst.icMap55, 1, "140"),
       EventData("2022-01-01 19:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 20:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 21:14:00", ImageConst.icMap55, 1, "140"),
      // EventData("2022-01-01 22:14:00", ImageConst.icMap45, 1, "140"),
      EventData("2022-01-01 23:00:00", ImageConst.icMap55, 1, "140"),
    ]),
  ];
  List<EventData> _selectedEvents = [];
  late AnimationController _animationController;
  late CalendarController _calendarController;

  final Map<DateTime, List> holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List<DayData> events) {
    setState(() {
      _selectedEvents = events.isEmpty ? [] : events.first.listEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildTableCalendar(),
          _buildButtons(),
          CalendarHorizontalWidget(_selectedEvents),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        selectedColor: Colors.blue,
        todayColor: Colors.blue,
        markersColor: Colors.blue,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            const TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: const Text('month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: const Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: const Text('week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: const Text('setDay 10-07-2019'),
          onPressed: () {
            _calendarController.setSelectedDay(DateTime(2019, 7, 10),
                runCallback: true);
          },
        ),
      ],
    );
  }
}
