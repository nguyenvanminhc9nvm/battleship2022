import 'dart:typed_data';

import 'package:battleship2022/ui/calendar/model/day_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChartCalendar extends CustomPainter {
  List<EventDataToDraw> eventData;

  ChartCalendar(this.eventData);

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;

    var paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var paintLine = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double yFirst = 5;
    double xDefault = 25;
    double xTimeline = 70;
    double xEventIcon = 100;
    var timeDistance = 0;
    double itemHeightDefault = 100;
    double itemWidthDefault = width - xDefault;

        Offset centerFirst = Offset(xTimeline, (itemHeightDefault / 2) + yFirst);
    _drawCircle(canvas, centerFirst);
    for (int item = 0; item < eventData.length; item++) {
      var firstIndex = item;
      var nextIndex = item + 1;

      var left = xDefault;
      var top = yFirst + timeDistance;
      var right = itemWidthDefault;
      var bottom = top + itemHeightDefault;

      RRect fullRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(
          left,
          top,
          right,
          bottom,
        ),
        const Radius.circular(50),
      );
      canvas.drawRRect(
        fullRect,
        paint,
      );
      var yCenterPoint = yFirst + timeDistance + (itemHeightDefault / 2);
      Offset centerPoint = Offset(xTimeline, yCenterPoint);
      _drawCircle(canvas, centerPoint);

      var yCenterIcon = yFirst + timeDistance + (itemHeightDefault / 3);
      Offset centerIcon = Offset(xEventIcon, yCenterIcon);
      _drawIconInChart(canvas, size, eventData[item].drawableRoot, centerIcon);
      yFirst = bottom;

      if (nextIndex == eventData.length) {
        break;
      }
      var startTime = DateTime.parse(eventData[firstIndex].dateTime);
      var nextTime = DateTime.parse(eventData[nextIndex].dateTime);
      timeDistance = nextTime.difference(startTime).inMinutes;

      print(
        "fI: $firstIndex, sT: $startTime, top: $top, nI: $nextIndex, nT: $nextTime, bottom: $bottom, length: ${eventData.length}, height: $height",
      );
    }

    canvas.drawLine(Offset(xTimeline, 0), Offset(xTimeline, height), paintLine);
  }

  _drawCircle(Canvas canvas, Offset offset) {
    //draw circle
    var paintFill = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var paintStroke = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(offset, 10, paintFill);
    canvas.drawCircle(offset, 10, paintStroke);
  }

  void _drawIconInChart(
    Canvas canvas,
    Size size,
    DrawableRoot? drawableRoot,
    Offset offset,
  ) {
    if (drawableRoot == null) {
      return;
    }
    Size desiredSize = const Size(40, 40);
// get the svg from a preloaded array of DrawableRoot corresponding to all the Svg I might use
    canvas.save();
// [center] below is the Offset of the center of the area where I want the Svg to be drawn
    canvas.translate(offset.dx, offset.dy);
    Size svgSize = drawableRoot.viewport.size;
    var matrix = Matrix4.identity();
    matrix.scale(
        desiredSize.width / svgSize.width, desiredSize.height / svgSize.height);
    canvas.transform(matrix.storage);
    drawableRoot.draw(canvas,
        Rect.zero); // the second argument is not used in DrawableRoot.draw() method
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
