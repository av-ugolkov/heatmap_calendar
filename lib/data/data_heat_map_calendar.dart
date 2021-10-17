import 'package:flutter/material.dart';

class DataHeatMapCalendar {
  final DateTime startDate;
  final DateTime finishDate;

  final Map<DateTime, int> input;
  final Map<int, Color> colorThresholds;

  final List<String> monthsLabels;
  final List<String> weekDaysLabels;

  final Color selectColor;
  final Function(DateTime)? onTapHeatMapDay;

  final double spaceMonth;
  final double cellHeight;
  final double opacityDisable;
  final double opacityDayOutOfMonth;

  final bool mondayFirstDayWeek;

  DataHeatMapCalendar({
    required this.startDate,
    required this.finishDate,
    required this.input,
    required this.colorThresholds,
    required this.monthsLabels,
    required this.weekDaysLabels,
    required this.selectColor,
    required this.onTapHeatMapDay,
    required this.spaceMonth,
    required this.cellHeight,
    required this.opacityDisable,
    required this.opacityDayOutOfMonth,
    required this.mondayFirstDayWeek,
  });
}
