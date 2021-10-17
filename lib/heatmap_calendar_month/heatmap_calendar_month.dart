import 'package:flutter/material.dart';
import 'package:heatmap_calendar/data/data_heat_map_calendar.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_day_label.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_list_view_months.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_month.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/inherited_heatmap_calendar_month.dart';
import 'package:heatmap_calendar/time_utils.dart';

class HeatMapCalendarMonth extends StatefulWidget {
  static const double margin = 4.0;

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

  const HeatMapCalendarMonth({
    Key? key,
    required this.startDate,
    required this.finishDate,
    required this.input,
    required this.colorThresholds,
    this.monthsLabels = TimeUtils.defaultMonthsLabels,
    this.weekDaysLabels = TimeUtils.defaultWeekLabels,
    this.selectColor = Colors.green,
    this.onTapHeatMapDay,
    this.spaceMonth = 20.0,
    this.cellHeight = 16.0,
    this.opacityDisable = 0.3,
    this.opacityDayOutOfMonth = 0.7,
    this.mondayFirstDayWeek = true,
  }) : super(key: key);

  @override
  _HeatMapCalendarMonthState createState() => _HeatMapCalendarMonthState();
}

class _HeatMapCalendarMonthState extends State<HeatMapCalendarMonth> {
  String _labelYearMonth = '';

  @override
  void initState() {
    super.initState();
    _labelYearMonth =
        '${widget.startDate.year} ${widget.monthsLabels[widget.startDate.month]}';
  }

  @override
  Widget build(BuildContext context) {
    return InheritedHeatMapCalendarMonth(
      data: DataHeatMapCalendar(
          startDate: widget.startDate,
          finishDate: widget.finishDate,
          input: widget.input,
          colorThresholds: widget.colorThresholds,
          monthsLabels: widget.monthsLabels,
          weekDaysLabels: widget.weekDaysLabels,
          selectColor: widget.selectColor,
          onTapHeatMapDay: widget.onTapHeatMapDay,
          spaceMonth: widget.spaceMonth,
          cellHeight: widget.cellHeight,
          opacityDisable: widget.opacityDisable,
          opacityDayOutOfMonth: widget.opacityDayOutOfMonth,
          mondayFirstDayWeek: widget.mondayFirstDayWeek),
      child: LayoutBuilder(builder: (context, constraints) {
        var cellWidth = (constraints.maxWidth - widget.spaceMonth * 2) /
            DateTime.daysPerWeek;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: widget.spaceMonth),
                child: Text(_labelYearMonth)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: widget.spaceMonth),
              child: HeatMapDayLabel(
                labelDays: widget.weekDaysLabels,
                cellWidth: cellWidth,
                cellHeight: widget.cellHeight,
              ),
            ),
            HeatMapListViewMonths(
              spaceItem: widget.spaceMonth,
              listMonths: _generateListMonths(cellWidth),
              heightWidget: 5 * widget.cellHeight,
              callbackEndScroll: (indexMonth) {
                setState(() {
                  var scrollDate = DateUtils.addMonthsToMonthDate(
                      widget.startDate, indexMonth);
                  _labelYearMonth =
                      '${scrollDate.year} ${widget.monthsLabels[scrollDate.month]}';
                });
              },
            ),
          ],
        );
      }),
    );
  }

  List<HeatMapMonth> _generateListMonths(double cellWidth) {
    final countMonth =
        DateUtils.monthDelta(widget.startDate, widget.finishDate);

    var listMonths = <HeatMapMonth>[];

    for (var i = 0; i <= countMonth; ++i) {
      var month = HeatMapMonth(
        addCountMonth: i,
        cellWidth: cellWidth,
      );
      listMonths.add(month);
    }
    return listMonths;
  }
}
