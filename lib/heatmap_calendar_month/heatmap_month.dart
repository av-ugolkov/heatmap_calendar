import 'package:flutter/material.dart';
import 'package:heatmap_calendar/data/data_heat_map_calendar.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/inherited_heatmap_calendar_month.dart';

class HeatMapMonth extends StatelessWidget {
  final int addCountMonth;
  final double cellWidth;

  const HeatMapMonth({
    Key? key,
    required this.addCountMonth,
    required this.cellWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = InheritedHeatMapCalendarMonth.of(context);

    var firstDateMonth =
        DateUtils.addMonthsToMonthDate(data.startDate, addCountMonth);
    var lastDateMonth = DateTime(firstDateMonth.year, firstDateMonth.month,
        DateUtils.getDaysInMonth(firstDateMonth.year, firstDateMonth.month));
    var month = _generateMonth(data, firstDateMonth, lastDateMonth, cellWidth);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: month,
      ),
    );
  }

  List<Row> _generateMonth(DataHeatMapCalendar data, DateTime firstDate,
      DateTime lastDate, double cellWidth) {
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
        nonExistDay = currentDate.isBefore(data.startDate) ||
            currentDate.isAfter(data.finishDate);
      }

      var heatmapDay = HeatMapDay(
        currentDay: currentDate,
        onTapCallback: nonExistDay
            ? null
            : (callback, date) {
                _callbackSelectDay?.call();
                _callbackSelectDay = callback;
                data.onTapHeatMapDay?.call(date);
              },
        width: cellWidth,
        opacity: _getOpacity(data, currentDate, firstDate, lastDate),
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

  double _getOpacity(DataHeatMapCalendar data, DateTime currentDay,
      DateTime firstDate, DateTime lastDate) {
    if (currentDay.isBefore(data.startDate) ||
        currentDay.isAfter(data.finishDate)) {
      return data.opacityDisable;
    }
    if (currentDay.isBefore(firstDate) || currentDay.isAfter(lastDate)) {
      return data.opacityDayOutOfMonth;
    }
    return 1;
  }
}
