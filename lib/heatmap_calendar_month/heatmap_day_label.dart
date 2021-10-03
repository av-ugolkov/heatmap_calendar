import 'package:flutter/material.dart';

class HeatMapDayLabel extends StatelessWidget {
  static const int marginHorizontal = 4;
  final List<String> labelDays;
  final double cellWidth;
  final double? cellHeight;

  const HeatMapDayLabel({
    Key? key,
    required this.labelDays,
    required this.cellWidth,
    this.cellHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = labelDays.map((label) {
      return SizedBox(
          width: cellWidth + marginHorizontal,
          height: cellHeight,
          child: Center(child: Text(label)));
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels,
    );
  }
}
