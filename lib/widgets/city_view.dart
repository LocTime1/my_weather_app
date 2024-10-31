// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_constructors

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/models/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/widgets/main_info.dart';

class CityView extends StatelessWidget {
  final WeatherForecast snapshot;
  final Future<LastData?> lastData;
  final _textEditingController = TextEditingController();
  CityView({super.key, required this.snapshot, required this.lastData});

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
                  height: height * 0.17,
                  width: size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/night.jpg"))),
                  child: MainInfo()),
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
