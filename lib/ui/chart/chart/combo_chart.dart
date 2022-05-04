import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constant/constant.dart';
import '../chart_screen.dart';
import '../model/chart_data.dart';
import '../model/line_chart.dart';
import '../model/monotoneX_data.dart';
import '../model/pillar_chart.dart';

class ComboChartWidget extends StatelessWidget {
  final List<BaseChart> listData;
  final BaseChart data;

  const ComboChartWidget(this.data, this.listData, {Key? key})
      : super(key: key);

  Future<DrawableRoot> _loadImageFromAssets() async {
    ByteData byteData = await rootBundle.load(ImageConst.icMap35);
    Uint8List uint8list = byteData.buffer.asUint8List();
    return await svg.fromSvgBytes(uint8list, "debugs");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImageFromAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomPaint(
            key: data.globalKey,
            painter: ComboChart(listData, data, snapshot.data as DrawableRoot),
            child: Container(),
          );
        }
        return Container();
      }
    );
  }
}

class ComboChart extends CustomPainter {
  final List<BaseChart> listData;
  final BaseChart data;

  ComboChart(this.listData, this.data, this.drawableRoot);

  DrawableRoot drawableRoot;


  late Offset center;

  @override
  void paint(Canvas canvas, Size size) {
    _drawIconInChart(canvas, size);
    _drawTimeLine(canvas, size);
    _drawPillarChart(canvas, size, listData);
    _drawLineChart(canvas, size, listData);
    _drawMonotoneXChart(canvas, size, listData);
    if (data is LineChartData) {
      _drawCircleLineChart(canvas, size, data, listData);
    }
  }

  void _drawTimeLine(Canvas canvas, Size size) {
    var coordinatesXs = [
      CoordinatesX(0, const Offset(0, 0)),
      CoordinatesX(6, Offset((size.width) / (24 / 6), 0)),
      CoordinatesX(12, Offset((size.width) / (24 / 12), 0)),
      CoordinatesX(18, Offset((size.width) / (24 / 18), 0)),
      CoordinatesX(24, Offset(size.width, 0)),
    ];
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    var height = size.height;
    var width = size.width;

    //draw timeline
    for (int i = 0; i < coordinatesXs.length; i++) {
      Offset startingPoint = coordinatesXs[i].offsetX;
      Offset endingPoint = Offset(coordinatesXs[i].offsetX.dx, height);

      canvas.drawLine(startingPoint, endingPoint, paint);
    }
    Offset startAxisX = Offset(0, height);
    Offset endAxisX = Offset(size.width, height);
    canvas.drawLine(startAxisX, endAxisX, paint);
  }

  void _drawPillarChart(
    Canvas canvas,
    Size size,
    List<BaseChart> listData,
  ) {
    var pillarData = listData.whereType<PillarChartData>().toList();
    var paintBlood = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    var height = size.height;
    var width = size.width;
    var maxPillar = pillarData.fold<int>(
      0,
      (previousValue, element) =>
          element.value > previousValue ? element.value : previousValue,
    );
    var pillarDataMoreThanHeight = maxPillar > height;

    //draw blood
    for (int i = 0; i < pillarData.length; i++) {
      Offset endBlood = OffsetTimelineConst.initEndOrStart<PillarChartData>(
        width,
        height,
        pillarData[i],
        pillarDataMoreThanHeight,
        maxPillar,
      );
      Offset startBlood = Offset(endBlood.dx, height);
      canvas.drawLine(startBlood, endBlood, paintBlood);
    }
  }

  void _drawLineChart(
    Canvas canvas,
    Size size,
    List<BaseChart> listData,
  ) {
    var lineChartData = listData.whereType<LineChartData>().toList();
    var paintMeal = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    var height = size.height;
    var width = size.width;

    var maxKaLo = lineChartData.fold<int>(
      0,
      (previousValue, element) =>
          element.value > previousValue ? element.value : previousValue,
    );
    var mealValueMoreThanHeight = maxKaLo > height;

    //draw meals
    for (int i = 0; i < lineChartData.length; i++) {
      var index = i;
      var nextIndex = i + 1;
      if (nextIndex < lineChartData.length) {
        Offset offsetStart = OffsetTimelineConst.initEndOrStart<LineChartData>(
          width,
          height,
          lineChartData[index],
          mealValueMoreThanHeight,
          maxKaLo,
        );
        Offset offsetEnd = OffsetTimelineConst.initEndOrStart<LineChartData>(
          width,
          height,
          lineChartData[nextIndex],
          mealValueMoreThanHeight,
          maxKaLo,
        );

        //print("start: x: ${offsetStart.dx}, y: ${offsetStart.dy}, end: x: ${offsetEnd.dx}, y: ${offsetEnd.dy}");
        canvas.drawLine(offsetStart, offsetEnd, paintMeal);
      }
    }
  }

  void _drawCircleLineChart(Canvas canvas, Size size,BaseChart data, List<BaseChart> listData) {
    var listChartData = listData.whereType<LineChartData>().toList();
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var height = size.height;
    var width = size.width;

    var maxKaLo = listChartData.fold<int>(
      0,
          (previousValue, element) =>
      element.value > previousValue ? element.value : previousValue,
    );
    var mealValueMoreThanHeight = maxKaLo > height;

    center = OffsetTimelineConst.initEndOrStart<LineChartData>(
      width,
      height,
      (data as LineChartData),
      mealValueMoreThanHeight,
      maxKaLo,
    );

    canvas.drawCircle(center, 5, paint);
  }

  void _drawMonotoneXChart(
    Canvas canvas,
    Size size,
    List<BaseChart> listData,
  ) {
    var monotoneXListData = listData.whereType<MonotoneXData>().toList();
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var height = size.height;
    var width = size.width;

    var maxHealth = monotoneXListData.fold<int>(
      0,
      (previousValue, element) =>
          element.value > previousValue ? element.value : previousValue,
    );
    var healthValueMoreThanHeight = maxHealth > height;

    Path path = Path();
    var points = monotoneXListData
        .map((e) => OffsetTimelineConst.initPoint<MonotoneXData>(
            width, height, e, healthValueMoreThanHeight, maxHealth))
        .toList();
    var newPath = MonotoneX.addCurve(path, points);
    canvas.drawPath(newPath, paint);
  }

  void _drawIconInChart(Canvas canvas, Size size) {
    Size desiredSize = const Size(40, 40);
// get the svg from a preloaded array of DrawableRoot corresponding to all the Svg I might use
    canvas.save();
// [center] below is the Offset of the center of the area where I want the Svg to be drawn
    canvas.translate(100, 100);
    Size svgSize = drawableRoot.viewport.size;
    var matrix = Matrix4.identity();
    matrix.scale(desiredSize.width / svgSize.width, desiredSize.height / svgSize.height);
    canvas.transform(matrix.storage);
    drawableRoot.draw(canvas, Rect.zero); // the second argument is not used in DrawableRoot.draw() method
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool? hitTest(Offset position) {
    final Path path = Path();
    if (data is LineChartData) {
      path.addRect(Rect.fromCircle(center: center, radius: 5));
    }
    return path.contains(position);
  }
}
