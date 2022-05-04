import 'package:battleship2022/ui/chart/model/chart_data.dart';
import 'package:battleship2022/ui/chart/model/line_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PointerPaintWidget extends StatelessWidget {
  final List<LineChartData> lineChartData;
  final LineChartData data;

  const PointerPaintWidget(this.data, this.lineChartData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: PointerPaint(data, lineChartData),
    );
  }
}

class PointerPaint extends CustomPainter {
  final LineChartData data;
  final List<LineChartData> lineChartData;

  PointerPaint(this.data, this.lineChartData);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var paintLine = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var height = size.height;
    var width = size.width;

    var maxKaLo = lineChartData.fold<int>(
      0,
          (previousValue, element) =>
      element.value > previousValue ? element.value : previousValue,
    );
    var mealValueMoreThanHeight = maxKaLo > height;

    Offset center = OffsetTimelineConst.initEndOrStart<LineChartData>(
      width,
      height,
      data,
      mealValueMoreThanHeight,
      maxKaLo,
    );

    var dtStart = DateTime.parse(data.time);
    var hour = dtStart.hour;
    var minutes = dtStart.minute;
    var timeInMinute = 60 / minutes;
    var timeInHour = 1 / timeInMinute;
    var separateTime = hour + timeInHour;
    var offsetX = (width / (24 / separateTime));
    Offset startPointer = Offset(offsetX, 0);
    Offset endPointer = Offset(offsetX, height);
    canvas.drawLine(startPointer, endPointer, paintLine);
    canvas.drawCircle(center, 5, paint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

