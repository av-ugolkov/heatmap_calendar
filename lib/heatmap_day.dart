import 'package:flutter/material.dart';

typedef TapHeatMapDayCallback = void Function(VoidCallback, DateTime);

class HeatMapDay extends StatefulWidget {
  final int value;
  final double size;
  final Map<int, Color> thresholds;
  final Color activeColor;
  final Color disabledColor;
  final DateTime currentDay;
  final double opacity;
  final Duration animationDuration;
  final TextStyle? textStyle;
  final TapHeatMapDayCallback? onTapCallback;
  final Color selectColor;

  const HeatMapDay(
      {Key? key,
      required this.value,
      required this.size,
      required this.thresholds,
      this.activeColor = Colors.grey,
      this.disabledColor = Colors.black12,
      required this.selectColor,
      required this.currentDay,
      this.opacity = 1,
      this.animationDuration = const Duration(milliseconds: 300),
      this.textStyle,
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
    return GestureDetector(
      onTap: () {
        if (widget.onTapCallback != null) {
          widget.onTapCallback?.call(deselect, widget.currentDay);
          setState(() {
            _isSelect = true;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: widget.size + 4,
        height: widget.size + 4,
        color: _isSelect ? widget.selectColor : Colors.white,
        child: Container(
          alignment: Alignment.center,
          width: widget.size,
          height: widget.size,
          color: widget.onTapCallback == null
              ? widget.disabledColor
              : _getColorFromThreshold(),
          child: AnimatedOpacity(
            opacity: widget.opacity,
            duration: widget.animationDuration,
            child: Text(
              widget.currentDay.day.toString(),
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
