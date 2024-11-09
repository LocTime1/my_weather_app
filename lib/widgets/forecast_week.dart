// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/screens/another_day_screen.dart';
import 'package:page_transition/page_transition.dart';

class ForecastWeek extends StatelessWidget {
  final Future<WeatherForecast>? forecast;
  ForecastWeek({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.3,
      width: size * 0.9,
      color: Colors.red,
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return MyCard(
              index: index,
              forecast: forecast,
            );
          }),
    );
  }
}

class MyCard extends StatelessWidget {
  final int index;
  final Future<WeatherForecast>? forecast;
  const MyCard({super.key, required this.index, required this.forecast});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: AnotherDayScreen(
                  forecastData: forecast,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        color: Colors.green,
        width: size * 0.85,
        child: Row(
          children: [Text("Завтра")],
        ),
      ),
    );
  }
}
