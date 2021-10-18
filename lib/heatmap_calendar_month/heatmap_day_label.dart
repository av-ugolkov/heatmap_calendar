import 'package:flutter/material.dart';

import 'heatmap_calendar_month.dart';

class HeatMapDayLabel extends StatelessWidget {
  final List<String> labelDays;
  final double cellWidth;
  final double cellHeight;

  const HeatMapDayLabel({
    Key? key,
    required this.labelDays,
    required this.cellWidth,
    required this.cellHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = labelDays.map((label) {
      return Container(
        alignment: Alignment.center,
        width: cellWidth,
        height: cellHeight,
        child: Container(
          alignment: Alignment.center,
          width: cellWidth - HeatMapCalendarMonth.margin,
          height: cellHeight,
          child: Text(label),
        ),
      );
    }).toList();

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: labels,
      ),
    );
  }
}
