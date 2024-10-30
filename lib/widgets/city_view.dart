// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/models/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

class CityView extends StatelessWidget {
  final WeatherForecast snapshot;
  final Future<LastData?> lastData;
  CityView({super.key, required this.snapshot, required this.lastData});

  @override
  Widget build(BuildContext context) {
    Future<String?> city = lastData.then((res) => res!.city);
    Future<String?> country = lastData.then((res) => res!.country);

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([city, country]),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            var _city = snapshot2.data![0];
            var _country = snapshot2.data![1];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_city}, ${_country}",
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.location!.localtime.toString(),
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // Future<Translation> translateToRussian(String sourceText) async {
  //   print('AAA');
  //   final translator = GoogleTranslator();
  //   var textOnRussian =
  //       await translator.translate(sourceText, from: 'en', to: 'ru');
  //   print(textOnRussian.text);
  //   return textOnRussian;
  // }
}
