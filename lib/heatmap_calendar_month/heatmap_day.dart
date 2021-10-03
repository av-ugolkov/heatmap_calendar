import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_day.dart';

class HeatMapDay extends StatefulWidget {
  static const int margin = 4;

  final DateTime currentDay;
  final int value;
  final Map<int, Color> thresholds;
  final Color activeColor;
  final Color disabledColor;
  final Color selectColor;
  final double width;
  final double height;
  final double opacity;
  final TapHeatMapDayCallback? onTapCallback;

  const HeatMapDay(
      {Key? key,
      required this.currentDay,
      required this.value,
      required this.width,
      required this.height,
      required this.opacity,
      required this.thresholds,
      required this.selectColor,
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

  Color _getColorFromThreshold() {
    Color color = widget.activeColor;
    widget.thresholds.forEach((mapKey, mapColor) {
      if (widget.value >= mapKey) {
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
          width: widget.width + HeatMapDay.margin,
          height: widget.height + HeatMapDay.margin,
          color: _isSelect ? widget.selectColor : Colors.white,
          child: Container(
            alignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            color: widget.onTapCallback == null
                ? widget.disabledColor
                : _getColorFromThreshold(),
            child: Center(
              child: Text(widget.currentDay.day.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
