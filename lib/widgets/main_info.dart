// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/models/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

class MainInfo extends StatelessWidget {
  final WeatherForecast snapshot;
  final Future<LastData?> lastData;
  final _textEditingController = TextEditingController();
  MainInfo({super.key, required this.snapshot, required this.lastData});

  @override
  Widget build(BuildContext context) {
    Future<String?> city = lastData.then((res) => res!.city);
    Future<String?> country = lastData.then((res) => res!.country);
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([city, country]),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            var _city = snapshot2.data![0];
            var _country = snapshot2.data![1];
            return Padding(
              padding: EdgeInsets.only(
                  top: 20, left: size * 0.03, right: size * 0.03),
              child: Container(
                  height: height * 0.22,
                  width: size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/night_sky.jpg"))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * 0.085, vertical: height * 0.022),
                    child: Column(
                      // Всё что в котейнере
                      children: [
                        Row(
                          // Всё кроме нижней строчки
                          children: [
                            Column(
                              // Температура
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "В $_city сейчас:",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                    snapshot.current!.tempC! > 0
                                        ? "+${snapshot.current!.tempC!.round()}°"
                                        : "${snapshot.current!.tempC!.round()}°",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.055)),
                                Text(
                                  snapshot.current!.feelslikeC! > 0
                                      ? "ощущается как: +${snapshot.current!.feelslikeC!.round()}°"
                                      : "ощущается как: ${snapshot.current!.feelslikeC!.round()}°",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.network(
                                    "https:${snapshot.current!.condition!.icon}",
                                    scale: 0.8)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
