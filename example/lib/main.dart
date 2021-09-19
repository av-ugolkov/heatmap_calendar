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
          input: {
            TimeUtils.removeTime(
                DateTime.now().subtract(const Duration(days: 3))): 5,
            TimeUtils.removeTime(
                DateTime.now().subtract(const Duration(days: 2))): 35,
            TimeUtils.removeTime(
                DateTime.now().subtract(const Duration(days: 1))): 14,
            TimeUtils.removeTime(DateTime.now()): 5,
          },
          colorThresholds: {
            1: Colors.green.shade100,
            10: Colors.green.shade300,
            30: Colors.green.shade500
          },
          weekDaysLabels: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          monthsLabels: const [
            "",
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          squareSize: 20.0,
          textOpacity: 0.3,
          labelTextColor: Colors.blueGrey,
          dayTextColor: Colors.blue.shade500,
        ),
      ),
    );
  }
}
