import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_month.dart';

class HeatMapListViewMonths extends StatelessWidget {
  final List<HeatMapMonth> listMonths;
  final double heightWidget;
  final Function(int) callbackEndScroll;
  const HeatMapListViewMonths({
    Key? key,
    required this.listMonths,
    required this.heightWidget,
    required this.callbackEndScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return SizedBox(
      height: heightWidget,
      child: NotificationListener(
        child: ListView.builder(
          controller: scrollController,
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: listMonths.length,
          itemBuilder: (context, index) {
            return listMonths[index];
          },
        ),
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            var numMonth = notification.metrics.extentBefore /
                notification.metrics.extentInside;
            callbackEndScroll(numMonth.round());
          }
          return true;
        },
      ),
    );
  }
}
