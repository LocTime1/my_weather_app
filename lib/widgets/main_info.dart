// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/models/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

class MainInfo extends StatelessWidget {
  final WeatherForecast snapshot;
  final Future<LastData?> lastData;
  MainInfo({super.key, required this.snapshot, required this.lastData});

  @override
  Widget build(BuildContext context) {
    Future<String?> city = lastData.then((res) => res!.city);
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: city,
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            var _city = snapshot2.data!;
            return Padding(
              padding: EdgeInsets.only(
                  top: height * 0.0382,
                  left: size * 0.03,
                  right: size * 0.03,
                  bottom: height * 0.0382),
              child: Container(
                  height: height * 0.29,
                  width: size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/night_sky.jpg"))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size * 0.03, vertical: height * 0.022),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Всё что в котейнере
                      children: [
                        Row(
                          // Всё кроме нижней строчки
                          children: [
                            Container(
                              width: size * 0.41,
                              height: height * 0.165,
                              child: Column(
                                // Температура
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(
                                    width: size * 0.41,
                                    child: AutoSizeText(
                                      "В $_city сейчас:",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size * 0.06),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size * 0.41,
                                    height: height * 0.1,
                                    child: AutoSizeText(
                                        snapshot.current!.tempC! > 0
                                            ? "+${snapshot.current!.tempC!.round()}°"
                                            : "${snapshot.current!.tempC!.round()}°",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.1)),
                                  ),
                                  SizedBox(
                                    width: size * 0.41,
                                    child: AutoSizeText(
                                      maxLines: 1,
                                      snapshot.current!.feelslikeC! > 0
                                          ? "ощущается как: +${snapshot.current!.feelslikeC!.round()}°"
                                          : "ощущается как: ${snapshot.current!.feelslikeC!.round()}°",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size * 0.06),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  snapshot.current!.isDay == 1
                                      ? day_icon[
                                          snapshot.current!.condition!.text]!
                                      : night_icon[
                                          snapshot.current!.condition!.text]!,
                                  height: size * 0.177,
                                ),
                                SizedBox(
                                  height: size * 0.177,
                                  width: size * 0.286,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      maxLines: 2,
                                      "${snapshot.current!.condition!.text}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size * 0.05),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.017,
                        ),
                        BottomLine(
                            windKph: snapshot.current!.windKph!,
                            humidity: snapshot.current!.humidity!,
                            pressureMb: snapshot.current!.pressureMb!)
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

class BottomLine extends StatelessWidget {
  final double windKph;
  final int humidity;
  final double pressureMb;
  const BottomLine(
      {super.key,
      required this.windKph,
      required this.humidity,
      required this.pressureMb});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return Container(
      width: size * 0.938,
      height: height * 0.0625,
      child: Row(
        children: [
          Image.asset(
            "assets/icons/wind.png",
            scale: 0.7,
            height: height * 0.0525,
          ),
          SizedBox(
            height: height * 0.025,
            child: AutoSizeText(
              "$windKph м/с",
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: size * 0.05),
            ),
          ),
          SizedBox(
            width: size * 0.03,
          ),
          Image.asset(
            "assets/icons/water.png",
            scale: 0.7,
            height: height * 0.0525,
          ),
          SizedBox(
            height: height * 0.025,
            child: AutoSizeText(
              maxLines: 1,
              "$humidity%",
              style: TextStyle(color: Colors.white, fontSize: size * 0.05),
            ),
          ),
          SizedBox(
            width: size * 0.03,
          ),
          Image.asset(
            "assets/icons/pressure.png",
            scale: 0.7,
            height: height * 0.0525,
          ),
          SizedBox(
            height: height * 0.025,
            child: AutoSizeText(
              "${(pressureMb * 0.750064).round()}мм.рт.ст.",
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: size * 0.05),
            ),
          ),
        ],
      ),
    );
  }
}
