import 'package:flutter/material.dart';

typedef TapHeatMapDayCallback = void Function(DateTime);

class HeatMapDay extends StatelessWidget {
  final int value;
  final double size;
  final Map<int, Color> thresholds;
  final Color activeColor;
  final Color disabledColor;
  final DateTime currentDay;
  final double opacity;
  final Duration animationDuration;
  final Color textColor;
  final FontWeight? fontWeight;
  final TapHeatMapDayCallback? onTapCallback;

  const HeatMapDay(
      {Key? key,
      required this.value,
      required this.size,
      required this.thresholds,
      this.activeColor = Colors.grey,
      this.disabledColor = Colors.black12,
      required this.currentDay,
      this.opacity = 0.3,
      this.animationDuration = const Duration(milliseconds: 300),
      this.textColor = Colors.black,
      this.fontWeight,
      this.onTapCallback})
      : super(key: key);

  Color getColorFromThreshold() {
    Color color = activeColor;
    thresholds.forEach((mapKey, mapColor) {
      if (value >= mapKey) {
        color = mapColor;
      }
    });

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapCallback?.call(currentDay),
      child: Container(
        alignment: Alignment.center,
        height: size,
        width: size,
        color: onTapCallback == null ? disabledColor : getColorFromThreshold(),
        margin: const EdgeInsets.all(2.0),
        child: AnimatedOpacity(
          opacity: opacity,
          duration: animationDuration,
          child: Text(
            currentDay.day.toString(),
            style: TextStyle(fontWeight: fontWeight, color: textColor),
          ),
        ),
      ),
    );
  }
}
