import 'package:flutter/material.dart';

class HeatMapDay extends StatelessWidget {
  final DateTime currentDate;

  const HeatMapDay({
    Key? key,
    required this.currentDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(currentDate.day.toString()),
    );
  }
}
