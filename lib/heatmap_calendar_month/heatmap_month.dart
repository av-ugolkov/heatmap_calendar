import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day.dart';

class HeatMapMonth extends StatelessWidget {
  final DateTime startDate;
  final DateTime finishDate;
  final int addCountMonth;
  final Map<DateTime, int> input;
  final Map<int, Color> colorThresholds;
  final Color selectColor;
  final Function(DateTime)? onTapHeatMapDay;

  final double cellWidth;
  final double cellHeight;
  final double opacityDisable;
  final double opacityDayOutOfMonth;

  const HeatMapMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    required this.addCountMonth,
    required this.input,
    required this.colorThresholds,
    required this.selectColor,
    required this.onTapHeatMapDay,
    required this.cellWidth,
    required this.cellHeight,
    required this.opacityDisable,
    required this.opacityDayOutOfMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstDateMonth =
        DateUtils.addMonthsToMonthDate(startDate, addCountMonth);
    var lastDateMonth = DateTime(firstDateMonth.year, firstDateMonth.month,
        DateUtils.getDaysInMonth(firstDateMonth.year, firstDateMonth.month));
    var month = _generateMonth(firstDateMonth, lastDateMonth, cellWidth);

    return Column(children: month);
  }

  List<Row> _generateMonth(
      DateTime firstDate, DateTime lastDate, double cellWidth) {
    final firstDayMonth = DateTime(firstDate.year, firstDate.month, 1);
    var firstDayWeek = firstDayMonth.weekday;

    var currentDate = DateTime(firstDate.year, firstDate.month, 1)
        .subtract(Duration(days: firstDayWeek - 1));

    VoidCallback? _callbackSelectDay;

    var month = <Row>[];
    var week = <HeatMapDay>[];
    for (var i = 0; i < 35; ++i) {
      var nonExistDay = true;
      if (currentDate.month == firstDate.month) {
        nonExistDay =
            currentDate.isBefore(startDate) || currentDate.isAfter(finishDate);
      }

      var heatmapDay = HeatMapDay(
        currentDay: currentDate,
        onTapCallback: nonExistDay
            ? null
            : (callback, date) {
                _callbackSelectDay?.call();
                _callbackSelectDay = callback;
                onTapHeatMapDay?.call(date);
              },
        width: cellWidth,
        height: cellHeight,
        opacity: _getOpacity(currentDate, firstDate, lastDate),
        thresholds: colorThresholds,
        value: input[currentDate] ?? 0,
        selectColor: selectColor,
      );
      week.add(heatmapDay);
      if (week.length == 7) {
        var row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: week,
        );
        month.add(row);
        week = [];
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return month;
  }

  double _getOpacity(
      DateTime currentDay, DateTime firstDate, DateTime lastDate) {
    if (currentDay.isBefore(startDate) || currentDay.isAfter(finishDate)) {
      return opacityDisable;
    }
    if (currentDay.isBefore(firstDate) || currentDay.isAfter(lastDate)) {
      return opacityDayOutOfMonth;
    }
    return 1;
  }
}
