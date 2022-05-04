import 'package:battleship2022/ui/chart/chart/combo_chart.dart';
import 'package:battleship2022/ui/chart/model/chart_data.dart';
import 'package:battleship2022/ui/chart/model/line_chart.dart';
import 'package:battleship2022/ui/chart/model/pillar_chart.dart';
import 'package:battleship2022/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'chart/pointer.dart';
import 'model/monotoneX_data.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<PillarChartData> pillarData = [
    PillarChartData("2022-01-01 06:30:00", 150),
    PillarChartData("2022-01-01 07:20:00", 250),
    PillarChartData("2022-01-01 08:30:00", 1250),
    PillarChartData("2022-01-01 09:40:00", 100),
    PillarChartData("2022-01-01 12:45:00", 152),
    PillarChartData("2022-01-01 15:25:00", 190),
  ];

  List<LineChartData> lineChartData = [
    LineChartData("2022-01-01 00:00:00", 0),
    LineChartData("2022-01-01 02:30:00", 110),
    LineChartData("2022-01-01 03:30:00", 10),
    LineChartData("2022-01-01 04:45:00", 200),
    LineChartData("2022-01-01 05:30:00", 300),
    LineChartData("2022-01-01 06:30:00", 100),
    LineChartData("2022-01-01 07:30:00", 199),
    LineChartData("2022-01-01 08:30:00", 108),
    LineChartData("2022-01-01 09:30:00", 208),
    LineChartData("2022-01-01 10:30:00", 308),
    LineChartData("2022-01-01 11:30:00", 108),
    LineChartData("2022-01-01 12:30:00", 580),
    LineChartData("2022-01-01 13:30:00", 108),
    LineChartData("2022-01-01 14:30:00", 108),
    LineChartData("2022-01-01 15:30:00", 18),
    LineChartData("2022-01-01 16:30:00", 108),
    LineChartData("2022-01-01 17:30:00", 108),
    LineChartData("2022-01-01 18:30:00", 208),
    LineChartData("2022-01-01 19:30:00", 208),
    LineChartData("2022-01-01 20:30:00", 118),
  ];

  List<MonotoneXData> listMonotoneXData = [
    MonotoneXData("2022-01-01 00:00:00", 0),
    MonotoneXData("2022-01-01 06:00:00", 100),
    MonotoneXData("2022-01-01 08:00:00", 300),
    MonotoneXData("2022-01-01 16:00:00", 500),
    MonotoneXData("2022-01-01 17:00:00", 700),
    MonotoneXData("2022-01-01 23:00:00", 300),
  ];

  List<Widget> lineChartWidget = [];

  @override
  void initState() {

    List<BaseChart> listData = [pillarData, lineChartData, listMonotoneXData]
        .expand((element) => element)
        .toList();
    lineChartWidget.addAll(listData.map((e) => ComboChartWidget(e, listData)));
    //lineChartWidget.addAll(lineChartData.map((e) => PointerCircleWidget(e, lineChartData)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Listener(
            onPointerDown: (event) {
              print("condition: $event");
              lineChartData.firstWhere((element) {
                var condition = determineClick(element, event);
                if (condition) {
                  setState(() {
                    if (lineChartWidget.length > lineChartData.length) {
                      lineChartWidget.removeLast();
                    }
                    var pointerPaintWidget = PointerPaintWidget(
                      element,
                      lineChartData,
                      key: UniqueKey(),
                    );
                    lineChartWidget.add(pointerPaintWidget);
                  });
                }
                return condition;
              });

            },
            child: Stack(children: lineChartWidget,),
          ),
        ),
      ),
    );
  }

  bool determineClick(BaseChart meals, PointerEvent details) {
    final RenderBox? hexagonBox =
        meals.globalKey.currentContext?.findRenderObject() as RenderBox?;
    final result = BoxHitTestResult();
    if (hexagonBox?.hitTest(result, position: details.localPosition) == true) {
      return true;
    }
    return false;
  }
}

class TimeLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CoordinatesX {
  int time;
  Offset offsetX;

  CoordinatesX(this.time, this.offsetX);
}

class CoordinatesY {
  int milestone;
  Offset offsetY;

  CoordinatesY(this.milestone, this.offsetY);
}

const String svgStringData =
    "PHN2ZyB3aWR0aD0iMTAyIiBoZWlnaHQ9IjEwNSIgdmlld0JveD0iMCAwIDEwMiAxMDUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Ik0wIDVDMCAyLjIzODU4IDIuMjM4NTggMCA1IDBIOTdDOTkuNzYxNCAwIDEwMiAyLjIzODU4IDEwMiA1VjEwMEMxMDIgMTAyLjc2MSA5OS43NjE0IDEwNSA5NyAxMDVINUMyLjIzODU4IDEwNSAwIDEwMi43NjEgMCAxMDBWNVoiIGZpbGw9IiMxODJGMzAiLz4KPGxpbmUgeDE9IjI2LjUiIHkxPSIxOSIgeDI9IjI2LjUiIHkyPSI4NyIgc3Ryb2tlPSJ3aGl0ZSIvPgo8bGluZSB4MT0iNTEuNSIgeTE9IjE5IiB4Mj0iNTEuNSIgeTI9Ijg3IiBzdHJva2U9IndoaXRlIi8+CjxsaW5lIHgxPSI3Ny41IiB5MT0iMTkiIHgyPSI3Ny41IiB5Mj0iODciIHN0cm9rZT0id2hpdGUiLz4KPGxpbmUgeDE9IjE3IiB5MT0iNDAuNSIgeDI9Ijg1IiB5Mj0iNDAuNSIgc3Ryb2tlPSJ3aGl0ZSIvPgo8bGluZSB4MT0iMTciIHkxPSI2Ni41IiB4Mj0iODUiIHkyPSI2Ni41IiBzdHJva2U9IndoaXRlIi8+CjxwYXRoIGQ9Ik00Mi45MiA2Ny4zNkM0MC42OCA2Ny4zNiAzOC42OCA2Ny4wMjY3IDM2LjkyIDY2LjM2QzM1LjE4NjcgNjUuNjkzMyAzMy44MjY3IDY0Ljc2IDMyLjg0IDYzLjU2QzMxLjg4IDYyLjM2IDMxLjQgNjAuOTg2NyAzMS40IDU5LjQ0QzMxLjQgNTguMTA2NyAzMS44NCA1Ny4xNDY3IDMyLjcyIDU2LjU2QzMzLjYyNjcgNTUuOTczMyAzNS4wOTMzIDU1LjY4IDM3LjEyIDU1LjY4QzM3LjA0IDU2LjE4NjcgMzcgNTYuODI2NyAzNyA1Ny42QzM3IDU5LjE0NjcgMzcuNDkzMyA2MC4zMiAzOC40OCA2MS4xMkMzOS40OTMzIDYxLjg5MzMgNDAuOTczMyA2Mi4yOCA0Mi45MiA2Mi4yOEM0Ni43ODY3IDYyLjI4IDQ4LjcyIDYxLjEyIDQ4LjcyIDU4LjhDNDguNzIgNTYuNCA0Ny4wNjY3IDU1LjIgNDMuNzYgNTUuMkg0Mi40OEM0MS43MzMzIDU1LjIgNDEuMTMzMyA1NC45NzMzIDQwLjY4IDU0LjUyQzQwLjIyNjcgNTQuMDY2NyA0MCA1My40NjY3IDQwIDUyLjcyQzQwIDUxLjk3MzMgNDAuMjI2NyA1MS4zNzMzIDQwLjY4IDUwLjkyQzQxLjEzMzMgNTAuNDY2NyA0MS43MzMzIDUwLjI0IDQyLjQ4IDUwLjI0SDQzLjhDNDUuMTg2NyA1MC4yNCA0Ni4yMTMzIDQ5Ljk3MzMgNDYuODggNDkuNDRDNDcuNTczMyA0OC44OCA0Ny45MiA0OC4wNCA0Ny45MiA0Ni45MkM0Ny45MiA0NS45MDY3IDQ3LjQ5MzMgNDUuMTIgNDYuNjQgNDQuNTZDNDUuODEzMyA0NCA0NC42MjY3IDQzLjcyIDQzLjA4IDQzLjcyQzQxLjM0NjcgNDMuNzIgNDAgNDQuMDI2NyAzOS4wNCA0NC42NEMzOC4xMDY3IDQ1LjIyNjcgMzcuNjQgNDYuMDY2NyAzNy42NCA0Ny4xNkMzNy42NCA0Ny42MTMzIDM3LjY5MzMgNDguMjEzMyAzNy44IDQ4Ljk2QzM2LjEyIDQ5LjAxMzMgMzQuNzQ2NyA0OC43MzMzIDMzLjY4IDQ4LjEyQzMyLjYxMzMgNDcuNTA2NyAzMi4wOCA0Ni42OCAzMi4wOCA0NS42NEMzMi4wOCA0NC4yOCAzMi41MzMzIDQzLjA2NjcgMzMuNDQgNDJDMzQuMzczMyA0MC45MzMzIDM1LjY2NjcgNDAuMTA2NyAzNy4zMiAzOS41MkMzOSAzOC45MzMzIDQwLjkyIDM4LjY0IDQzLjA4IDM4LjY0QzQ1LjI0IDM4LjY0IDQ3LjEzMzMgMzguOTg2NyA0OC43NiAzOS42OEM1MC4zODY3IDQwLjM0NjcgNTEuNjQgNDEuMzA2NyA1Mi41MiA0Mi41NkM1My40MjY3IDQzLjgxMzMgNTMuODggNDUuMjY2NyA1My44OCA0Ni45MkM1My44OCA0OS4zNDY3IDUyLjY0IDUxLjI4IDUwLjE2IDUyLjcyQzUxLjc4NjcgNTMuNDY2NyA1Mi45NDY3IDU0LjMwNjcgNTMuNjQgNTUuMjRDNTQuMzMzMyA1Ni4xNDY3IDU0LjY4IDU3LjMzMzMgNTQuNjggNTguOEM1NC42OCA2MC40OCA1NC4xODY3IDYxLjk3MzMgNTMuMiA2My4yOEM1Mi4yMTMzIDY0LjU2IDUwLjgyNjcgNjUuNTYgNDkuMDQgNjYuMjhDNDcuMjggNjcgNDUuMjQgNjcuMzYgNDIuOTIgNjcuMzZaTTY4LjczMzggNjcuMzZDNjYuNjgwNCA2Ny4zNiA2NC43ODcxIDY3LjAyNjcgNjMuMDUzOCA2Ni4zNkM2MS4zNDcxIDY1LjY5MzMgNTkuOTg3MSA2NC44IDU4Ljk3MzggNjMuNjhDNTcuOTg3MSA2Mi41MzMzIDU3LjQ5MzggNjEuMjY2NyA1Ny40OTM4IDU5Ljg4QzU3LjQ5MzggNTguNjUzMyA1Ny44NTM4IDU3Ljc2IDU4LjU3MzggNTcuMkM1OS4yOTM4IDU2LjY0IDYwLjQ0MDQgNTYuMzYgNjIuMDEzOCA1Ni4zNkM2Mi40NDA0IDU2LjM2IDYyLjc3MzggNTYuMzczMyA2My4wMTM4IDU2LjRDNjIuOTA3MSA1Ni43NDY3IDYyLjg1MzggNTcuMzA2NyA2Mi44NTM4IDU4LjA4QzYyLjg1MzggNTkuMzg2NyA2My4zNzM4IDYwLjQxMzMgNjQuNDEzOCA2MS4xNkM2NS40ODA0IDYxLjg4IDY2LjkyMDQgNjIuMjQgNjguNzMzOCA2Mi4yNEM3MC42MDA0IDYyLjI0IDcyLjA0MDQgNjEuNzYgNzMuMDUzOCA2MC44Qzc0LjA2NzEgNTkuODQgNzQuNTczOCA1OC40NjY3IDc0LjU3MzggNTYuNjhDNzQuNTczOCA1NS4wNTMzIDc0LjA0MDQgNTMuNzczMyA3Mi45NzM4IDUyLjg0QzcxLjkzMzggNTEuOTA2NyA3MC40ODA0IDUxLjQ0IDY4LjYxMzggNTEuNDRDNjYuNTg3MSA1MS40NCA2NC44NDA0IDUxLjk0NjcgNjMuMzczOCA1Mi45NkM2Mi43MDcxIDUzLjQ0IDYxLjk2MDQgNTMuNjggNjEuMTMzOCA1My42OEM2MC4zMzM4IDUzLjY4IDU5LjY1MzggNTMuNDUzMyA1OS4wOTM4IDUzQzU4LjUzMzggNTIuNTIgNTguMjUzOCA1MS44OTMzIDU4LjI1MzggNTEuMTJDNTguMjUzOCA1MC45MDY3IDU4LjI2NzEgNTAuNzQ2NyA1OC4yOTM4IDUwLjY0TDU5Ljg5MzggNDEuMTJDNjAuMTMzOCAzOS43MDY3IDYxLjA2NzEgMzkgNjIuNjkzOCAzOUg3OS4wNTM4Qzc5LjA1MzggNDIuMzMzMyA3Ny43MjA0IDQ0IDc1LjA1MzggNDRINjQuMzczOEw2My43MzM4IDQ3LjcyQzYzLjA0MDQgNDguMTQ2NyA2Mi40NjcxIDQ4LjYxMzMgNjIuMDEzOCA0OS4xMkw2Mi4yNTM4IDQ5LjRDNjMuMjQwNCA0OC41NDY3IDY0LjQ2NzEgNDcuODY2NyA2NS45MzM4IDQ3LjM2QzY3LjQwMDQgNDYuODI2NyA2OC44MjcxIDQ2LjU2IDcwLjIxMzggNDYuNTZDNzIuMjEzOCA0Ni41NiA3My45NzM4IDQ2Ljk3MzMgNzUuNDkzOCA0Ny44Qzc3LjAxMzggNDguNjI2NyA3OC4xODcxIDQ5LjgxMzMgNzkuMDEzOCA1MS4zNkM3OS44NDA0IDUyLjg4IDgwLjI1MzggNTQuNjUzMyA4MC4yNTM4IDU2LjY4QzgwLjI1MzggNTkuOTg2NyA3OS4yMjcxIDYyLjYgNzcuMTczOCA2NC41MkM3NS4xMjA0IDY2LjQxMzMgNzIuMzA3MSA2Ny4zNiA2OC43MzM4IDY3LjM2WiIgZmlsbD0iIzAwRkZGRiIvPgo8L3N2Zz4K";
