// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/models/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeather(String locationDevice) async {
    Map<String, String?> parameters;
    parameters = {
      'key': "5fa6e0752e2d4172a2193433240410",
      'q': locationDevice,
      'lang': 'ru',
      'days': "3"
    };

    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', parameters);
    print(url);
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-16'
    });
    if (response.statusCode == 200) {
      var futureForecast = WeatherForecast.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      var lastData = await DBProvider.db.getLastData();
      if (lastData == null) {
        DBProvider.db.insertData(LastData(
          lat: futureForecast.location!.lat,
          long: futureForecast.location!.lon,
          city: futureForecast.location!.name,
        ));
      }
      return futureForecast;
    } else {
      return Future.error('Error response');
    }
  }

  // Future<String> translateToRussian(String sourceText) async {
  //   final translator = GoogleTranslator();
  //   var textOnRussian =
  //       await translator.translate(sourceText, from: 'en', to: 'ru');
  //   print(textOnRussian.text);
  //   return textOnRussian.text;
  // }
}
