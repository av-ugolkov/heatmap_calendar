import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_month.dart';
import 'package:heatmap_calendar/time_utils.dart';

class HeatMapCalendarMonth extends StatefulWidget {
  static const double margin = 4.0;

  final DateTime startDate;
  final DateTime finishDate;

  final Map<DateTime, int> input;
  final Map<int, Color> colorThresholds;

  final List<String> monthsLabels;
  final List<String> weekDaysLabels;

  final Function(DateTime)? onTapHeatMapDay;

  final double cellHeight;
  final double disableOpacity;

  final bool mondayFirstDayWeek;
  final int marginHorizontal;

  const HeatMapCalendarMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    required this.input,
    required this.colorThresholds,
    this.monthsLabels = TimeUtils.defaultMonthsLabels,
    this.weekDaysLabels = TimeUtils.defaultWeekLabels,
    this.onTapHeatMapDay,
    this.cellHeight = 16.0,
    this.disableOpacity = 0.5,
    this.mondayFirstDayWeek = true,
    this.marginHorizontal = 0,
  }) : super(key: key);

  @override
  _HeatMapCalendarMonthState createState() => _HeatMapCalendarMonthState();
}

class _HeatMapCalendarMonthState extends State<HeatMapCalendarMonth> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var cellWidth = (constraints.maxWidth - widget.marginHorizontal) /
              DateTime.daysPerWeek -
          HeatMapCalendarMonth.margin;
      return SizedBox(
        width: constraints.maxWidth - widget.marginHorizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${widget.startDate.year} ${widget.monthsLabels[widget.startDate.month]}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('M'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('T'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('W'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('T'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('F'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('S'))),
                SizedBox(
                    width: cellWidth + 4,
                    child: const Center(child: Text('S'))),
              ],
            ),
            HeatMapMonth(
              startDate: widget.startDate,
              finishDate: widget.finishDate,
              onTapHeatMapDay: widget.onTapHeatMapDay,
              cellHeight: widget.cellHeight,
              cellWidth: cellWidth,
              disableOpacity: widget.disableOpacity,
            ),
          ],
        ),
      );
    });
  }
}
