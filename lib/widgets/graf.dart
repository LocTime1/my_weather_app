import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    return Container(
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title

            series: <LineSeries<HourWeather, String>>[
          LineSeries<HourWeather, String>(
              dataSource: <HourWeather>[
                HourWeather("0", 1),
                HourWeather("1", -1),
                HourWeather("02", 4),
                HourWeather("03", 5),
                HourWeather("04", 10),
              ],
              xValueMapper: (HourWeather hourWeather, _) => hourWeather.hour,
              yValueMapper: (HourWeather hourWeather, _) => hourWeather.temp,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]));
  }
}

class HourWeather {
  String? hour;
  int? temp;
  HourWeather(this.hour, this.temp);
}
