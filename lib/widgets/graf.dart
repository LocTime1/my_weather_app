// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graf extends StatefulWidget {
  const Graf({super.key});

  @override
  State<Graf> createState() => _GrafState();
}

class _GrafState extends State<Graf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          padding: EdgeInsets.all(10),
          width: 700,
          height: 200,
          child: LineChart(
            LineChartData(
                titlesData: FlTitlesData(
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false))),
                lineBarsData: [
                  LineChartBarData(
                      spots: [FlSpot(1, 1), FlSpot(2, 3), FlSpot(4, 5)])
                ]),
          )),
    );
  }
}

class HourWeather {
  String? hour;
  int? temp;
  HourWeather(this.hour, this.temp);
}
