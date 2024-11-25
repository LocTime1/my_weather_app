// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

class AnotherHomeScreen extends StatefulWidget {
  final Future<WeatherForecast>? forecastData;
  AnotherHomeScreen({super.key, this.forecastData});
  @override
  State<AnotherHomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<AnotherHomeScreen> {
  late Future<WeatherForecast> forecast;
  @override
  void initState() {
    super.initState();
    if (widget.forecastData != null) {
      forecast = Future.value(widget.forecastData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 50, right: 20, left: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/night_background.png"))),
            child: Column(
              children: [
                // MyAppBar(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Заголовок
                    Text(
                      'Прогноз погоды',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    // График
                    SizedBox(
                      height: 220,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 800,
                          child: WeatherChart(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Иконки с текстом
                  ],
                ),
              ],
            )));
  }
}

class WeatherChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 7,
        minY: -6,
        maxY: 2,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, -3),
              FlSpot(1, -4),
              FlSpot(2, -6),
              FlSpot(3, -3),
              FlSpot(4, -1),
              FlSpot(5, 0),
              FlSpot(6, 1),
              FlSpot(7, -2),
// Четверг
            ],
            isCurved: true,
            // colors: [Colors.blue],
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: DBProvider.db.getLastData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _city = snapshot.data!.city!;
            return Container(
              // color: Colors.green,
              width: size,

              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/icons/left.png",
                        color: Colors.white,
                        width: height * 0.033,
                        scale: 0.5,
                      )),
                  SizedBox(
                    width: size * 0.28,
                  ),
                  Image.asset(
                    "assets/icons/Location.png",
                    height: height * 0.033,
                  ),
                  Container(
                    width: size * 0.31883,
                    height: height * 0.0338,
                    child: AutoSizeText(
                      maxLines: 1,
                      "$_city",
                      style:
                          TextStyle(color: Colors.white, fontSize: size * 0.07),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
