import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_day.dart';
import 'package:heatmap_calendar/month_label.dart';
import 'package:heatmap_calendar/time_utils.dart';

class WeekColumns extends StatelessWidget {
  final double squareSize;
  final Color labelTextColor;
  final Map<DateTime, int> input;
  final Map<int, Color> colorThresholds;
  final double currentOpacity;
  final List<String> monthLabels;
  final Color activeDayColor;
  final Color disabledDayColor;
  final Color selectSquareColor;
  final int minColumnsToCreate;
  final DateTime startDate;
  final DateTime finishDate;
  final DateTime date;
  final bool mondayFirstDayWeek;
  final Function(DateTime)? onTapHeatMapDay;
  final TextStyle? textStyleDate;

  const WeekColumns({
    Key? key,
    required this.squareSize,
    required this.labelTextColor,
    required this.input,
    required this.colorThresholds,
    required this.currentOpacity,
    required this.monthLabels,
    required this.minColumnsToCreate,
    required this.startDate,
    required this.finishDate,
    required this.date,
    required this.mondayFirstDayWeek,
    required this.activeDayColor,
    required this.disabledDayColor,
    required this.selectSquareColor,
    this.onTapHeatMapDay,
    this.textStyleDate,
  }) : super(key: key);

  List<Widget> buildWeekItems() {
    List<DateTime> dateList = _getCalendarDates();
    int totalDays = dateList.length;
    var daysPerWeek = DateTime.daysPerWeek;
    int totalWeeks = (totalDays / daysPerWeek).ceil();
    int amount = totalDays + totalWeeks;

    List<Widget> columns = [];

    List<Widget> columnItems = [];
    List<int> months = [];

    VoidCallback? _callbackSelectDay;

    for (int i = 0; i < amount; i++) {
      if (i % 8 == 0) {
        String month = "";

        if (dateList.isNotEmpty && !months.contains(dateList.first.month)) {
          month = monthLabels[dateList.first.month];
          months.add(dateList.first.month);
        }

        columnItems.add(MonthLabel(
          size: squareSize,
          textColor: labelTextColor,
          text: month,
        ));
      } else {
        DateTime currentDate = dateList.first;
        dateList.removeAt(0);

        var nonExistDay =
            currentDate.isBefore(startDate) || currentDate.isAfter(finishDate);
        HeatMapDay heatMapDay = HeatMapDay(
          key: Key(currentDate.toString()),
          value: input[currentDate] ?? 0,
          thresholds: colorThresholds,
          size: squareSize,
          activeColor: activeDayColor,
          disabledColor: disabledDayColor,
          selectColor: selectSquareColor,
          currentDay: currentDate,
          opacity: currentOpacity,
          textStyle: textStyleDate,
          onTapCallback: nonExistDay
              ? null
              : (callback, date) {
                  _callbackSelectDay?.call();
                  _callbackSelectDay = callback;
                  onTapHeatMapDay?.call(date);
                },
        );
        columnItems.add(heatMapDay);
        if (columnItems.length == 8) {
          columns.add(Column(children: columnItems));
          columnItems = [];
        }
      }
    }

    if (columnItems.isNotEmpty) {
      columns.add(Column(children: columnItems));
    }
    return columns;
  }

  List<DateTime> _getCalendarDates() {
    var firstDay = TimeUtils.firstDayOfTheWeek(DateUtils.dateOnly(startDate))
        .add(Duration(days: mondayFirstDayWeek ? 1 : 0));

    var offsetDay = 0;
    if (mondayFirstDayWeek) {
      offsetDay = DateTime.daysPerWeek - finishDate.weekday;
    } else {
      offsetDay = (DateTime.daysPerWeek - finishDate.weekday - 1) %
          DateTime.daysPerWeek;
    }

    var lastDay = DateUtils.dateOnly(finishDate).add(Duration(days: offsetDay));
    var period = lastDay.difference(firstDay);
    var createColumn = period.inDays ~/ DateTime.daysPerWeek;
    if (createColumn < minColumnsToCreate) {
      var countFirstColumns = (minColumnsToCreate - createColumn) ~/ 2;
      var addFirstDays = countFirstColumns * DateTime.daysPerWeek;
      firstDay = firstDay.subtract(Duration(days: addFirstDays));
      lastDay = lastDay.add(Duration(
          days: (minColumnsToCreate - createColumn - countFirstColumns) *
              DateTime.daysPerWeek));
    }
    var dateList = TimeUtils.datesBetween(firstDay, lastDay);

    return dateList;
  }

  @override
  Widget build(BuildContext context) {
    final items = buildWeekItems();
    var columnCurrentDay =
        DateUtils.dateOnly(DateTime.now()).difference(startDate).inDays ~/
            DateTime.daysPerWeek;

    var offset = (columnCurrentDay + 2) * (squareSize + 4) -
        MediaQuery.of(context).size.width;

    var scrollController = ScrollController(initialScrollOffset: offset);

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
