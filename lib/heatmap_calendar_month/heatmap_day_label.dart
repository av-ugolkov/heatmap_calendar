import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_calendar_month.dart';

class HeatMapDayLabel extends StatelessWidget {
  final List<String> labelDays;
  final double cellWidth;
  final double? cellHeight;

  const HeatMapDayLabel({
    Key? key,
    required this.labelDays,
    required this.cellWidth,
    this.cellHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = labelDays.map((label) {
      return SizedBox(
          width: cellWidth + HeatMapCalendarMonth.margin,
          height: cellHeight,
          child: Center(child: Text(label)));
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: labels,
    );
  }
}
