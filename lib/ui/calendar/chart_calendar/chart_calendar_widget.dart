import 'dart:typed_data';

import 'package:battleship2022/ui/calendar/model/day_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chart_calendar.dart';

class ChartCalendarWidget extends StatelessWidget {
  final List<EventData> evenData;

  const ChartCalendarWidget(this.evenData, {Key? key}) : super(key: key);

  Future<List<EventDataToDraw>> _loadImageFromAssets() async {
    List<EventDataToDraw> result = [];
    for (var element in evenData) {
      await _svgToByteData(element).then((value) {
        result.add(value);
      });
    }
    return Future.value(result);
  }

  Future<EventDataToDraw> _svgToByteData(EventData data) async {
    DrawableRoot? drawableRoot;
    ByteData byteData = await rootBundle.load(data.eventType);
    Uint8List uint8list = byteData.buffer.asUint8List();
    await svg.fromSvgBytes(uint8list, "debugs").then((value) {
      drawableRoot = value;
    });
    return Future.value(
      EventDataToDraw(
        data.dateTime,
        drawableRoot,
        data.status,
        data.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int listCount = evenData.length;
    int itemHeightDefault = 100;
    double totalTimeDistance = _calculatorTimeDistance(evenData);
    double height = (listCount * itemHeightDefault) + totalTimeDistance;
    return FutureBuilder(
      future: _loadImageFromAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data as List<EventDataToDraw>;
          return data.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: height,
                  child: CustomPaint(
                    painter: ChartCalendar(
                      data,
                    ),
                  ),
                )
              : Container();
        }
        return Container();
      },
    );
  }

  double _calculatorTimeDistance(List<EventData> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      var firstIndex = i;
      var nextIndex = i + 1;
      if (nextIndex < list.length) {
        var startTime = DateTime.parse(list[firstIndex].dateTime);
        var nextTime = DateTime.parse(list[nextIndex].dateTime);
        var timeDistance = nextTime.difference(startTime).inMinutes;
        total += timeDistance;
      }
    }
    return total;
  }
}
