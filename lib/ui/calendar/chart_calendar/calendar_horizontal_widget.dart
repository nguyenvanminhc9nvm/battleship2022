import 'package:battleship2022/ui/calendar/model/day_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarHorizontalWidget extends StatefulWidget {
  const CalendarHorizontalWidget(this.eventData, {Key? key}) : super(key: key);

  final List<EventData> eventData;

  @override
  State<CalendarHorizontalWidget> createState() =>
      _CalendarHorizontalWidgetState();
}

class _CalendarHorizontalWidgetState extends State<CalendarHorizontalWidget> {
  var dateTimeNow = DateTime.now();
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        // height: height,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.eventData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == widget.eventData.length - 1) {
              return _buildItemCalendarItem(
                firstEvent: widget.eventData[index],
              );
            }
            var firstIndex = index;
            var nextIndex = index + 1;

            return _buildItemCalendarItem(
              firstEvent: widget.eventData[firstIndex],
              nextEvent: widget.eventData[nextIndex],
            );
          },
        ),
      ),
    );
  }

  _buildItemCalendarItem({
    required EventData firstEvent,
    EventData? nextEvent,
  }) {
    var startTime = DateTime.parse(firstEvent.dateTime);
    var widgetSizeBox = const SizedBox();
    if (nextEvent != null) {
      var nextTime = DateTime.parse(nextEvent.dateTime);
      var timeDistance = nextTime.difference(startTime).inMinutes;
      var listCount = widget.eventData.length;
      double finalHeight = 0;
      if (listCount.isBetween(0, 8)) {
        finalHeight = timeDistance / 4;
      } else if (listCount.isBetween(9, 16)) {
        finalHeight = timeDistance / 3;
      } else if (listCount.isBetween(17, 24)) {
        finalHeight = timeDistance / 2;
      } else {
        finalHeight = timeDistance / 5;
      }
      print("time: ${firstEvent.dateTime}: distance: $finalHeight");
      widgetSizeBox = SizedBox(
        height: finalHeight,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    }
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 3),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    firstEvent.eventType,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    firstEvent.eventType,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    firstEvent.eventType,
                  ),
                ),
              ),
            ],
          ),
        ),
        widgetSizeBox
      ],
    );
  }
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}
