import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_month.dart';

class HeatMapListViewMonths extends StatelessWidget {
  final List<HeatMapMonth> listMonths;
  final double heightWidget;
  const HeatMapListViewMonths(
      {Key? key, required this.listMonths, required this.heightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightWidget,
      child: ListView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listMonths.length,
        itemBuilder: (context, index) {
          return listMonths[index];
        },
      ),
    );
  }
}
