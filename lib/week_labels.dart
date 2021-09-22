import 'package:flutter/material.dart';
import 'package:heatmap_calendar/default_container.dart';

class WeekLabels extends StatelessWidget {
  final List<String> weekDaysLabels;
  final double squareSize;
  final Color labelTextColor;
  final bool mondayfirstDayWeek;

  const WeekLabels(
      {Key? key,
      required this.weekDaysLabels,
      required this.squareSize,
      required this.labelTextColor,
      required this.mondayfirstDayWeek})
      : assert(weekDaysLabels.length == 7),
        assert(squareSize > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DefaultContainer(
          text: "",
          size: squareSize,
          textColor: labelTextColor,
          margin: 0,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(0)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(1)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(2)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(3)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(4)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(5)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[_getIndexWeekDay(6)],
          size: squareSize,
          textColor: labelTextColor,
        ),
      ],
    );
  }

  int _getIndexWeekDay(int index) {
    final offsetDay = mondayfirstDayWeek ? 0 : 6;
    return (index + offsetDay) % DateTime.daysPerWeek;
  }
}
