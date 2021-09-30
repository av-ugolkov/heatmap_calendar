import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day.dart';

class HeatMapCalendarMonth extends StatefulWidget {
  static const double margin = 4.0;

  final DateTime startDate;
  final DateTime finishDate;
  final double heightCell;
  final double disableOpacity;

  final bool mondayFirstDayWeek;

  const HeatMapCalendarMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    this.heightCell = 16.0,
    this.disableOpacity = 0.5,
    this.mondayFirstDayWeek = true,
  }) : super(key: key);

  @override
  _HeatMapCalendarMonthState createState() => _HeatMapCalendarMonthState();
}

class _HeatMapCalendarMonthState extends State<HeatMapCalendarMonth> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var cellWidth = constraints.maxWidth / DateTime.daysPerWeek -
          HeatMapCalendarMonth.margin;
      var month = _generateMonth(cellWidth);
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2021 ${widget.startDate.month}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: cellWidth + 4, child: Center(child: Text('M'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('T'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('W'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('T'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('F'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('S'))),
                SizedBox(width: cellWidth + 4, child: Center(child: Text('S'))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: month,
            )
          ],
        ),
      );
    });
  }

  List<Row> _generateMonth(double cellWidth) {
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
        width: cellWidth,
        height: widget.heightCell,
        opacity: _getOpacity(currentDay),
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
      currentDay = currentDay.add(const Duration(days: 1));
      if (currentDay.isAfter(lastDayMonth)) {
        continueAddDay = currentDay.weekday != DateTime.monday;
      }
    } while (continueAddDay);

    return month;
  }

  double _getOpacity(DateTime currentDay) {
    return currentDay == widget.startDate ||
            currentDay == widget.finishDate ||
            (currentDay.isAfter(widget.startDate) &&
                currentDay.isBefore(widget.finishDate))
        ? 1
        : widget.disableOpacity;
  }
}
