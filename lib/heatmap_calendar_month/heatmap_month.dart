import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day.dart';

class HeatMapMonth extends StatelessWidget {
  final DateTime startDate;
  final DateTime finishDate;
  final Function(DateTime)? onTapHeatMapDay;

  final double cellWidth;
  final double cellHeight;
  final double disableOpacity;

  const HeatMapMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    required this.onTapHeatMapDay,
    required this.cellWidth,
    required this.cellHeight,
    required this.disableOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var month = _generateMonth(cellWidth);

    return Column(children: month);
  }

  List<Row> _generateMonth(double cellWidth) {
    final firstDayMonth = DateTime(startDate.year, startDate.month, 1);
    var firstDayWeek = firstDayMonth.weekday;

    var currentDate = DateTime(startDate.year, startDate.month, 1)
        .subtract(Duration(days: firstDayWeek - 1));
    final lastDayMonth =
        DateTime(firstDayMonth.year, firstDayMonth.month + 1, 1)
            .subtract(const Duration(days: 1));

    VoidCallback? _callbackSelectDay;

    bool continueAddDay = true;
    var month = <Row>[];
    var week = <HeatMapDay>[];
    do {
      var nonExistDay =
          currentDate.isBefore(startDate) || currentDate.isAfter(finishDate);
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
        opacity: _getOpacity(currentDate),
        thresholds: const <int, Color>{},
        value: 0,
        selectColor: Colors.green,
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
      if (currentDate.isAfter(lastDayMonth)) {
        continueAddDay = currentDate.weekday != DateTime.monday;
      }
    } while (continueAddDay);

    return month;
  }

  double _getOpacity(DateTime currentDay) {
    return currentDay == startDate ||
            currentDay == finishDate ||
            (currentDay.isAfter(startDate) && currentDay.isBefore(finishDate))
        ? 1
        : disableOpacity;
  }
}
