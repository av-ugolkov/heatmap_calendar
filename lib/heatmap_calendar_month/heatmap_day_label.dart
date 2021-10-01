import 'package:flutter/material.dart';

class HeatMapDayLabel extends StatelessWidget {
  final List<String> labelDays;
  final double cellWidth;

  const HeatMapDayLabel({
    Key? key,
    required this.labelDays,
    required this.cellWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = labelDays.map((label) {
      return SizedBox(width: cellWidth + 4, child: Center(child: Text(label)));
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels,
    );
  }
}
