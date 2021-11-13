import 'package:flutter/material.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_columns.dart';
import 'package:heatmap_calendar/week_labels.dart';

class HeatMapCalendar extends StatefulWidget {
  static const double rowCount = 8;
  static const double edgeSize = 4;

  final List<String> weekDaysLabels;
  final List<String> monthsLabels;

  final DateTime startDate;
  final DateTime finishDate;

  final Map<DateTime, int> input;

  final Map<int, Color> colorThresholds;

  final Color activeSquareColor;
  final Color disabledSquareColor;
  final double squareSize;
  final Color selectSquareColor;
  final bool showDateLabel;

  final TextStyle? textStyleDateText;
  final double textOpacity;
  final Color labelTextColor;
  final double safetyMargin;

  final bool mondayfirstDayWeek;
  final Function(DateTime)? onTapHeatMapDay;

  const HeatMapCalendar({
    Key? key,
    required this.startDate,
    required this.finishDate,
    required this.input,
    required this.colorThresholds,
    this.weekDaysLabels = TimeUtils.defaultWeekLabels,
    this.monthsLabels = TimeUtils.defaultMonthsLabels,
    this.activeSquareColor = Colors.grey,
    this.disabledSquareColor = Colors.black12,
    this.squareSize = 16,
    this.showDateLabel = false,
    this.textOpacity = 0.2,
    this.labelTextColor = Colors.black,
    this.safetyMargin = 5,
    this.mondayfirstDayWeek = true,
    this.onTapHeatMapDay,
    this.textStyleDateText,
    this.selectSquareColor = Colors.green,
  }) : super(key: key);

  @override
  HeatMapCalendarState createState() => HeatMapCalendarState();
}

class HeatMapCalendarState extends State<HeatMapCalendar> {
  int _getMinColumnsToCreate(double maxWidth) {
    assert(maxWidth > (2 * (HeatMapCalendar.edgeSize + widget.squareSize)));

    final double widgetWidth = widget.squareSize + HeatMapCalendar.edgeSize;
    return (maxWidth - widget.safetyMargin) ~/ widgetWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: (widget.squareSize + HeatMapCalendar.edgeSize) *
                  HeatMapCalendar.rowCount -
              HeatMapCalendar.edgeSize,
          width: constraints.maxWidth,
          child: Row(
            children: <Widget>[
              WeekLabels(
                weekDaysLabels: widget.weekDaysLabels,
                squareSize: widget.squareSize,
                labelTextColor: widget.labelTextColor,
                mondayfirstDayWeek: widget.mondayfirstDayWeek,
              ),
              WeekColumns(
                squareSize: widget.squareSize,
                labelTextColor: widget.labelTextColor,
                input: widget.input,
                colorThresholds: widget.colorThresholds,
                currentOpacity: widget.showDateLabel ? widget.textOpacity : 0,
                monthLabels: widget.monthsLabels,
                minColumnsToCreate:
                    _getMinColumnsToCreate(constraints.maxWidth) - 1,
                startDate: widget.startDate,
                finishDate: widget.finishDate,
                mondayFirstDayWeek: widget.mondayfirstDayWeek,
                onTapHeatMapDay: widget.onTapHeatMapDay,
                activeDayColor: widget.activeSquareColor,
                disabledDayColor: widget.disabledSquareColor,
                selectSquareColor: widget.selectSquareColor,
                textStyleDate: widget.textStyleDateText,
              ),
            ],
          ),
        );
      },
    );
  }
}
