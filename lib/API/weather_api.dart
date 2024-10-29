// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_weather_app/models/weather_forecast.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeather(String locationDevice) async {
    Map<String, String?> parameters;
    parameters = {
      'key': "5fa6e0752e2d4172a2193433240410",
      'q': locationDevice,
      'lang': 'ru'
    };

    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', parameters);
    print(url);
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-16'
    });
    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      return Future.error('Error response');
    }
  }
}
