import 'package:flutter/material.dart';

class HeatMapMonth extends StatelessWidget {
  final DateTime currentDate;
  const HeatMapMonth({
    Key? key,
    required this.currentDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(currentDate.day.toString()),
    );
  }
}
