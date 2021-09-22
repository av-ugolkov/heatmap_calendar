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
    final offsetDay = mondayfirstDayWeek ? 0 : 6;

    int getIndexWeekDay(int index) {
      return (index + offsetDay) % DateTime.daysPerWeek;
    }

    return Column(
      children: <Widget>[
        DefaultContainer(
          text: "",
          size: squareSize,
          textColor: labelTextColor,
          margin: 0,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(0)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(1)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(2)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(3)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(4)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(5)],
          size: squareSize,
          textColor: labelTextColor,
        ),
        DefaultContainer(
          text: weekDaysLabels[getIndexWeekDay(6)],
          size: squareSize,
          textColor: labelTextColor,
        ),
      ],
    );
  }
}
