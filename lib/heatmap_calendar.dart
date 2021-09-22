import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:heatmap_calendar/week_columns.dart';
import 'package:heatmap_calendar/week_labels.dart';

class HeatMapCalendar extends StatefulWidget {
  static const double columnCount = 11;
  static const double rowCount = 8;
  static const double edgeSize = 4;

  /// The labels identifying the initials of the days of the week
  /// Defaults to [TimeUtils.defaultWeekLabels]
  final List<String> weekDaysLabels;

  /// The labels identifying the months of a year
  /// Defaults to [TimeUtils.defaultMonthsLabels]
  final List<String> monthsLabels;

  final DateTime startDate;
  final DateTime finishDate;

  /// The inputs that will fill the calendar with data
  final Map<DateTime, int> input;

  /// The thresholds which will map the given [input] to a color
  ///
  /// Make sure to map starting on number 1, so the user might notice the difference between
  /// a day that had no input and one that had
  /// Example: {1: Colors.green[100], 20: Colors.green[200], 40: Colors.green[300]}
  final Map<int, Color> colorThresholds;

  /// The size of each item of the calendar
  final double squareSize;

  final bool showDateLabel;

  /// The opacity of the text when the user double taps the widget
  final double textOpacity;

  /// The color of the texts in the weeks/months labels
  final Color labelTextColor;

  /// The color of the text that identifies the days
  final Color dayTextColor;

  /// Helps avoiding overspacing issues
  final double safetyMargin;

  final bool mondayfirstDayWeek;
  final TapHeatMapDayCallback? onTapHeatMapDay;

  const HeatMapCalendar(
      {Key? key,
      required this.startDate,
      required this.finishDate,
      required this.input,
      required this.colorThresholds,
      this.weekDaysLabels = TimeUtils.defaultWeekLabels,
      this.monthsLabels = TimeUtils.defaultMonthsLabels,
      this.squareSize = 16,
      this.showDateLabel = false,
      this.textOpacity = 0.2,
      this.labelTextColor = Colors.black,
      this.dayTextColor = Colors.black,
      this.safetyMargin = 5,
      this.mondayfirstDayWeek = true,
      this.onTapHeatMapDay})
      : super(key: key);

  @override
  HeatMapCalendarState createState() => HeatMapCalendarState();
}

class HeatMapCalendarState extends State<HeatMapCalendar> {
  bool displayDates = false;

  /// Calculates the right amount of columns to create based on [maxWidth]
  ///
  /// returns the number of columns that the widget should have
  int _getColumnsToCreate(double maxWidth) {
    assert(maxWidth > (2 * (HeatMapCalendar.edgeSize + widget.squareSize)));

    var delta = widget.finishDate.difference(widget.startDate);
    return delta.inDays ~/ 7;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: (widget.squareSize + HeatMapCalendar.edgeSize) *
              (HeatMapCalendar.rowCount + 1),
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
                dayTextColor: widget.dayTextColor,
                columnsToCreate: _getColumnsToCreate(constraints.maxWidth) - 1,
                date: DateTime.now(),
                startDate: widget.startDate,
                finishDate: widget.finishDate,
                mondayFirstDayWeek: widget.mondayfirstDayWeek,
                onTapHeatMapDay: widget.onTapHeatMapDay,
              )
            ],
          ),
        );
      },
    );
  }
}
