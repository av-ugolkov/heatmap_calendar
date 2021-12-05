import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/heatmap_calendar_month/heatmap_calendar_month.dart';
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
  final DateTime _startDate = DateTime(2022, 9, 14);
  DateTime _finishDate = DateTime(2022, 9, 21);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeatMapCalendar(
            startDate: DateTime.now().subtract(const Duration(days: 222)),
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
            weekDaysLabels: TimeUtils.defaultWeekLabels,
            monthsLabels: TimeUtils.defaultMonthsLabels,
            squareSize: 22.0,
            textOpacity: 1,
            showDateLabel: false,
            labelTextColor: Colors.blueGrey,
            textStyleDateText: const TextStyle(color: Colors.white),
            onTapHeatMapDay: (tapDate) {
              log(tapDate.toString());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: HeatMapCalendarMonth(
              startDate: _startDate,
              finishDate: _finishDate,
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
              selectColor: Colors.orange,
              onTapHeatMapDay: (tapDate) {
                log(tapDate.toString());
              },
              spaceMonth: 20,
              cellHeight: 28,
              weekDaysLabels: TimeUtils.defaultWeekLabels,
              scrollToDate: DateTime.now(),
            ),
          ),
          ElevatedButton(
            child: const Text('Select Date'),
            onPressed: () async {
              var datePicker = await showDatePicker(
                  context: context,
                  initialDate: _finishDate,
                  firstDate: _startDate,
                  lastDate: DateTime(9999));
              setState(() {
                _finishDate = datePicker ?? _finishDate;
              });
            },
          )
        ],
      ),
    );
  }
}
