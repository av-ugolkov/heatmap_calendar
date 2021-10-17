import 'package:flutter/material.dart';
import 'package:heatmap_calendar/data/data_heat_map_calendar.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_calendar_month.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/inherited_heatmap_calendar_month.dart';
import 'package:heatmap_calendar/heatmap_day.dart';

class HeatMapDay extends StatefulWidget {
  final DateTime currentDay;
  final Color activeColor;
  final Color disabledColor;
  final double width;
  final double opacity;
  final TapHeatMapDayCallback? onTapCallback;

  const HeatMapDay(
      {Key? key,
      required this.currentDay,
      required this.width,
      required this.opacity,
      this.activeColor = Colors.grey,
      this.disabledColor = Colors.black12,
      this.onTapCallback})
      : super(key: key);

  @override
  State<HeatMapDay> createState() => _HeatMapDayState();
}

class _HeatMapDayState extends State<HeatMapDay>
    with AutomaticKeepAliveClientMixin {
  bool _isSelect = false;

  @override
  bool get wantKeepAlive => true;

  Color _getColorFromThreshold(DataHeatMapCalendar data) {
    Color color = widget.activeColor;
    var value = data.input[widget.currentDay] ?? 0;
    data.colorThresholds.forEach((mapKey, mapColor) {
      if (value >= mapKey) {
        color = mapColor;
      }
    });
    return color;
  }

  void deselect() {
    setState(() {
      _isSelect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var data = InheritedHeatMapCalendarMonth.of(context);
    return GestureDetector(
      onTap: () {
        if (widget.onTapCallback != null) {
          widget.onTapCallback?.call(deselect, widget.currentDay);
          setState(() {
            _isSelect = true;
          });
        }
      },
      child: Opacity(
        opacity: widget.opacity,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: data.cellHeight,
          color: _isSelect ? data.selectColor : Colors.white,
          child: Container(
            alignment: Alignment.center,
            width: widget.width - HeatMapCalendarMonth.margin,
            height: data.cellHeight - HeatMapCalendarMonth.margin,
            color: widget.onTapCallback == null
                ? widget.disabledColor
                : _getColorFromThreshold(data),
            child: Center(
              child: Text(widget.currentDay.day.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
