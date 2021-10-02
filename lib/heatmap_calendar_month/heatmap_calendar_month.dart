import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day_label.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_list_view_months.dart';
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
  final double opacityDisable;
  final double opacityDayOutOfMonth;

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
    this.opacityDisable = 0.2,
    this.opacityDayOutOfMonth = 0.6,
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
            HeatMapDayLabel(
              labelDays: widget.weekDaysLabels,
              cellWidth: cellWidth,
            ),
            HeatMapListViewMonths(
              listMonths: _generateListMonths(cellWidth),
              heightWidget: 6 * widget.cellHeight,
            ),
          ],
        ),
      );
    });
  }

  List<HeatMapMonth> _generateListMonths(double cellWidth) {
    final countMonth =
        DateUtils.monthDelta(widget.startDate, widget.finishDate);

    var listMonths = <HeatMapMonth>[];

    for (var i = 0; i <= countMonth; ++i) {
      var month = HeatMapMonth(
        startDate: widget.startDate,
        finishDate: widget.finishDate,
        addCountMonth: i,
        onTapHeatMapDay: widget.onTapHeatMapDay,
        cellHeight: widget.cellHeight,
        cellWidth: cellWidth,
        opacityDisable: widget.opacityDisable,
        opacityDayOutOfMonth: widget.opacityDayOutOfMonth,
      );
      listMonths.add(month);
    }
    return listMonths;
  }
}
