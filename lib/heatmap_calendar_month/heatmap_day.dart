import 'package:flutter/material.dart';

class HeatMapDay extends StatelessWidget {
  final DateTime currentDate;
  final double width;
  final double height;
  final double opacity;

  const HeatMapDay({
    Key? key,
    required this.currentDate,
    required this.width,
    required this.height,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.center,
        height: height,
        margin: const EdgeInsets.all(2.0),
        child: Container(
          alignment: Alignment.center,
          width: width,
          color: Colors.grey,
          child: Center(
            child: Text(currentDate.day.toString()),
          ),
        ),
      ),
    );
  }
}
