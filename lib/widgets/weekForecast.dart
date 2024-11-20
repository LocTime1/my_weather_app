import 'package:flutter/material.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

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
            return Column(
              children: [
                Container(
                  height: height * 0.08,
                  width: size * 0.8883,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5, color: Color.fromRGBO(10, 133, 218, 45)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(day_icon[forecast
                          .forecast!.forecastday![index].day!.condition!.text]!)
                    ],
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
}
