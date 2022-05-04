import 'package:battleship2022/ui/health_calendar/model/health_data.dart';
import 'package:battleship2022/ui/health_calendar/style/health_calendar_style.dart';
import 'package:flutter/material.dart';

class HealthCellWidget extends StatelessWidget {
  const HealthCellWidget({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.healthCalendarStyle,
  }) : super(key: key);

  final HealthData data;
  final bool isSelected;
  final HealthCalendarStyle healthCalendarStyle;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.center,
      decoration: isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(0.2),
            )
          : const BoxDecoration(),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(64),
        },
        children: [_generateTableRowData(data.list)],
      ),
    );
  }

  TableRow _generateTableRowData(List<FiguresHealthData> data) {
    return TableRow(
      children: data
          .map(
            (e) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  child: Text(
                    e.data.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  child: Text(
                    e.count.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
