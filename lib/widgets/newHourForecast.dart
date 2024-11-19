// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NewHourForecast extends StatelessWidget {
  final WeatherForecast forecast;
  final ItemScrollController _scrollController = ItemScrollController();
  NewHourForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
          index: int.parse(
              forecast.location!.localtime!.split(" ")[1].split(":")[0]));
    });
    return Container(
      height: height * 0.17339,
      width: size * 0.8883,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color.fromRGBO(10, 133, 218, 45)),
          borderRadius: BorderRadius.circular(10)),
      child: ScrollablePositionedList.builder(
          itemScrollController: _scrollController,
          itemCount: 24,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String? icon =
                forecast.forecast!.forecastday![0].hour![index].condition!.text;
            int temp =
                forecast.forecast!.forecastday![0].hour![index].tempC!.round();
            if (index != 23) {
              return Row(
                children: [
                  Container(
                    width: size * 0.2184,
                    child: Column(
                      children: [
                        Image.asset(
                          forecast.forecast!.forecastday![0].hour![index]
                                      .isDay ==
                                  1
                              ? day_icon[icon]!
                              : night_icon[icon]!,
                          width: 60,
                        ),
                        Text(
                          temp > 0 ? "+${temp}" : "${temp}",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          index + 1 < 10 ? "0${index}:00" : "${index}:00",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1.5,
                    color: Color.fromRGBO(10, 133, 218, 45),
                  )
                ],
              );
            } else {
              return Container(
                width: size * 0.2184,
                child: Column(
                  children: [
                    Image.asset(
                      forecast.forecast!.forecastday![0].hour![index].isDay == 1
                          ? day_icon[icon]!
                          : night_icon[icon]!,
                      width: 60,
                    ),
                    Text(
                      temp > 0 ? "+${temp}" : "${temp}",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      index + 1 < 10 ? "0${index}:00" : "${index}:00",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
