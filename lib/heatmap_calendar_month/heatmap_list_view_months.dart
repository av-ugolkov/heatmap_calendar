import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_month.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/inherited_heatmap_calendar_month.dart';

import 'heatmap_calendar_month.dart';

class HeatMapListViewMonths extends StatefulWidget {
  final List<HeatMapMonth> listMonths;
  final double heightWidget;
  final double spaceItem;
  final Function(int) callbackEndScroll;

  const HeatMapListViewMonths({
    Key? key,
    required this.listMonths,
    required this.heightWidget,
    this.spaceItem = 10,
    required this.callbackEndScroll,
  }) : super(key: key);

  @override
  State<HeatMapListViewMonths> createState() => _HeatMapListViewMonthsState();
}

class _HeatMapListViewMonthsState extends State<HeatMapListViewMonths> {
  bool _autoScroll = false;
  double _monthWidth = 0.0;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var data = InheritedHeatMapCalendarMonth.of(context);
    final maxWidth = MediaQuery.of(context).size.width;
    _monthWidth =
        (data.cellWidth + HeatMapCalendarMonth.margin) * DateTime.daysPerWeek -
            data.spaceMonth;

    return SizedBox(
      height: widget.heightWidget,
      child: NotificationListener(
        child: ListView.builder(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: widget.spaceItem),
          itemCount: widget.listMonths.length,
          itemBuilder: (context, index) {
            return widget.listMonths[index];
          },
        ),
        onNotification: (notification) {
          if (!_autoScroll && notification is ScrollEndNotification) {
            _autoScroll = true;
            var scroll = (_scrollController.offset / _monthWidth).round();
            var scrollPosition = scroll * (maxWidth - widget.spaceItem * 1.5);
            _animScroll(scrollPosition);
            widget.callbackEndScroll.call(scroll);
          }
          return _autoScroll;
        },
      ),
    );
  }

  _animScroll(double scrollPosition) {
    Future.delayed(Duration.zero, () {
      _scrollController
          .animateTo(scrollPosition,
              duration: const Duration(milliseconds: 300), curve: Curves.linear)
          .whenComplete(() => _autoScroll = false);
    });
  }
}
