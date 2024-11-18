// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class NewMainInfo extends StatelessWidget {
  final WeatherForecast forecast;
  NewMainInfo({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    String maxTemp =
        forecast.forecast!.forecastday![0].day!.maxtempC!.round() > 0
            ? "+${forecast.forecast!.forecastday![0].day!.maxtempC!.round()}°"
            : "${forecast.forecast!.forecastday![0].day!.maxtempC!.round()}°";
    String minTemp =
        forecast.forecast!.forecastday![0].day!.mintempC!.round() > 0
            ? "+${forecast.forecast!.forecastday![0].day!.mintempC!.round()}°"
            : "${forecast.forecast!.forecastday![0].day!.mintempC!.round()}°";
    return Container(
      width: size * 0.8883,
      height: height * 0.34,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: size * 0.8883,
              height: height * 0.2853,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/mainInfoBackground.png")),
                border: Border.all(
                    width: 2, color: Color.fromRGBO(0, 127, 217, 100)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  Divider(
                    color: Color.fromRGBO(0, 127, 217, 100),
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        forecast.current!.feelslikeC!.round() > 0
                            ? "ощущается как +${forecast.current!.feelslikeC!.round()}°"
                            : "ощущается как ${forecast.current!.feelslikeC!.round()}°",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "макс $maxTemp мин $minTemp",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Text(
                    forecast.current!.tempC!.round() > 0
                        ? "+${forecast.current!.tempC!.round()}°"
                        : "${forecast.current!.tempC!.round()}°",
                    style: TextStyle(color: Colors.white, fontSize: 60),
                  ),
                  Text("${forecast.current!.condition!.text}",
                      style: TextStyle(color: Colors.white)),
                  Divider(
                    color: Color.fromRGBO(0, 127, 217, 100),
                    thickness: 1.5,
                  ),
                  BottomLine(
                      windKph: forecast.current!.windKph!,
                      humidity: forecast.current!.humidity!,
                      pressureMb: forecast.current!.pressureMb!)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 93,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size * 0.045,
                  ),
                  Text(
                    "${forecast.location!.localtime!.split(' ')[1]}",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  SizedBox(
                    width: size * 0.15,
                  ),
                  Image.asset(
                    forecast.current!.isDay == 1
                        ? day_icon[forecast.current!.condition!.text]!
                        : night_icon[forecast.current!.condition!.text]!,
                    height: size * 0.28398,
                    scale: 0.55,
                  ),
                  SizedBox(
                    width: size * 0.2,
                  ),
                  Text(
                      getDayOfWeek(forecast.location!.localtime!.split(' ')[0]),
                      style: TextStyle(color: Colors.white, fontSize: 23))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getDayOfWeek(String dateString) {
    // Разбиваем строку на компоненты: день, месяц, год
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Создаем объект DateTime
    DateTime date = DateTime(year, month, day);

    // Получаем день недели (1 = понедельник, 7 = воскресенье)
    int weekday = date.weekday;

    // Массив с днями недели
    List<String> daysOfWeek = [
      'Пн', // 1
      'Вт', // 2
      'Ср', // 3
      'Чт', // 4
      'Пят', // 5
      'Сб', // 6
      'Вс', // 7
    ];

    // Возвращаем день недели по индексу
    return daysOfWeek[weekday - 1];
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
              "${(pressureMb * 0.750064).round()}мм.рт.",
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: size * 0.05),
            ),
          ),
        ],
      ),
    );
  }
}
