// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:translator/translator.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  CityView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    Future<Translation> city =
        translateToRussian(snapshot.data!.location!.name.toString());
    Future<Translation> country =
        translateToRussian(snapshot.data!.location!.country.toString());

    return FutureBuilder<List<Translation>>(
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
                      "${_city.text}, ${_country.text}",
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.location!.localtime.toString(), style: TextStyle(fontSize: 24),)
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

  Future<Translation> translateToRussian(String sourceText) async {
    print('AAA');
    final translator = GoogleTranslator();
    var textOnRussian =
        await translator.translate(sourceText, from: 'en', to: 'ru');
    print(textOnRussian.text);
    return textOnRussian;
  }
}
