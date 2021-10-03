import 'package:flutter/material.dart';
import 'package:heatmap_calendar/data/data_heat_map_calendar.dart';

class InheritedHeatMapCalendarMonth extends InheritedWidget {
  final DataHeatMapCalendar data;

  const InheritedHeatMapCalendarMonth(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedHeatMapCalendarMonth oldWidget) {
    return oldWidget.data != data;
  }

  static DataHeatMapCalendar of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedHeatMapCalendarMonth>()!
        .data;
  }
}
