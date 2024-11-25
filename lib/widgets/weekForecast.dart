// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/screens/another_home_screen.dart';
import 'package:page_transition/page_transition.dart';

class Weekforecast extends StatelessWidget {
  final WeatherForecast forecast;

  Weekforecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.27339,
      width: size * 0.8883,
      // color: Color.fromRGBO(10, 133, 218, 45),
      // decoration: BoxDecoration(
      //     border:
      //         Border.all(width: 1.5, color: Color.fromRGBO(10, 133, 218, 45)),
      //     borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            var _forecast =
                WeatherApi().fetchWeather('${forecast.location!.name}');
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: AnotherHomeScreen(
                              forecastData: _forecast,
                            )));
                  },
                  child: Container(
                    height: height * 0.08,
                    width: size * 0.8883,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: Color.fromRGBO(10, 133, 218, 45)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Image.asset(day_icon[forecast.forecast!
                            .forecastday![index].day!.condition!.text]!),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${getDayOfWeek(forecast.forecast!.forecastday![index].date!)}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 30,),
                        SizedBox(
                          width: size * 0.1,
                          child: AutoSizeText(
                            maxLines: 1,
                            minFontSize: 1,
                            "${forecast.forecast!.forecastday![index].day!.maxtempC!.round()}/${forecast.forecast!.forecastday![index].day!.mintempC!.round()}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(
                          width: size * 0.36,
                          child: AutoSizeText(
                            maxLines: 1,
                            minFontSize: 1,
                            "${forecast.forecast!.forecastday![index].day!.condition!.text}", style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
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
