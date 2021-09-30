import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day.dart';

class HeatMapCalendarMonth extends StatefulWidget {
  final DateTime startDate;
  final DateTime finishDate;

  final bool mondayfirstDayWeek;

  const HeatMapCalendarMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    this.mondayfirstDayWeek = true,
  }) : super(key: key);

  @override
  _HeatMapCalendarMonthState createState() => _HeatMapCalendarMonthState();
}

class _HeatMapCalendarMonthState extends State<HeatMapCalendarMonth> {
  @override
  Widget build(BuildContext context) {
    var month = _generateMonth();

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('2021'),
          const Text('month'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: month,
          )
        ],
      ),
    );
  }

  List<Row> _generateMonth() {
    final firstDayMonth =
        DateTime(widget.startDate.year, widget.startDate.month, 1);
    var firstDayWeek = firstDayMonth.weekday;

    var currentDay = DateTime(widget.startDate.year, widget.startDate.month, 1)
        .subtract(Duration(days: firstDayWeek - 1));
    final lastDayMonth =
        DateTime(firstDayMonth.year, firstDayMonth.month + 1, 1)
            .subtract(const Duration(days: 1));

    bool continueAddDay = true;
    var month = <Row>[];
    var week = <HeatMapDay>[];
    do {
      var heatmapDay = HeatMapDay(
        currentDate: currentDay,
      );
      week.add(heatmapDay);
      if (week.length == 7) {
        var row = Row(
          children: week,
        );
        month.add(row);
        week.clear();
      }
      currentDay = currentDay.add(const Duration(days: 1));
      if (currentDay.isAfter(lastDayMonth)) {
        continueAddDay = currentDay.weekday != DateTime.monday;
      }
    } while (continueAddDay);

    return month;
  }
}
