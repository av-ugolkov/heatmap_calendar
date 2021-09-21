import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Example Heatmap Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: HeatMapCalendar(
          startDate: DateTime.now().subtract(const Duration(days: 32)),
          finishDate: DateTime.now().add(const Duration(days: 80)),
          input: {
            DateUtils.dateOnly(
                DateTime.now().subtract(const Duration(days: 3))): 5,
            DateUtils.dateOnly(
                DateTime.now().subtract(const Duration(days: 2))): 35,
            DateUtils.dateOnly(
                DateTime.now().subtract(const Duration(days: 1))): 14,
            DateUtils.dateOnly(DateTime.now()): 5,
          },
          colorThresholds: {
            1: Colors.green.shade100,
            10: Colors.green.shade300,
            30: Colors.green.shade500
          },
          weekDaysLabels: const [
            'M',
            'T',
            'W',
            'T',
            'F',
            'S',
            'S',
          ],
          monthsLabels: TimeUtils.defaultMonthsLabels,
          squareSize: 20.0,
          textOpacity: 0.3,
          labelTextColor: Colors.blueGrey,
          dayTextColor: Colors.blue.shade500,
        ),
      ),
    );
  }
}
