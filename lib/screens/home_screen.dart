// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/widgets/newHourForecast.dart';
// import 'package:my_weather_app/widgets/forecast_week.dart';
// import 'package:my_weather_app/widgets/hourForecast.dart';
// import 'package:my_weather_app/widgets/main_info.dart';
// import 'package:my_weather_app/widgets/my_appbar.dart';
import 'package:my_weather_app/widgets/new_appBar.dart';
import 'package:my_weather_app/widgets/new_main_info.dart';
// import 'package:my_weather_app/widgets/new_main_info.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  Future<WeatherForecast>? forecastData;
  HomeScreen({super.key, this.forecastData});
  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  late Future<WeatherForecast> forecast;
  @override
  void initState() {
    super.initState();
    if (widget.forecastData != null) {
      forecast = Future.value(widget.forecastData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: FutureBuilder(
              future: forecast,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<double> temp = [];
                  snapshot.data!.forecast!.forecastday!.forEach(
                      (v) => v.hour!.forEach((i) => temp.add(i.tempC!)));
                  List<String> icons = [];
                  snapshot.data!.forecast!.forecastday!.forEach((v) =>
                      v.hour!.forEach((i) => icons.add(i.condition!.text!)));
                  List<int> listIsDay = [];
                  snapshot.data!.forecast!.forecastday!.forEach(
                      (v) => v.hour!.forEach((i) => listIsDay.add(i.isDay!)));
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "assets/images/night_background.png"))),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  NewAppbar(),

                                  NewMainInfo(
                                    forecast: snapshot.data!,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  NewHourForecast(
                                    forecast: snapshot.data!,
                                  )
                                  // MainInfo(
                                  //   snapshot: snapshot.data!,
                                  // ),
                                  // HourForecast(
                                  //   temp: temp,
                                  //   icons: icons,
                                  //   listIsDay: listIsDay,
                                  //   dateTime:
                                  //       snapshot.data!.location!.localtime!,
                                  // ),
                                  // ForecastWeek(
                                  //   forecast: forecast,
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  Future<void> _pullRefresh() async {
    var val = await DBProvider.db.getLastData();
    var _forecast = WeatherApi().fetchWeather(val!.city!);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: HomeScreen(
              forecastData: _forecast,
            )));
  }
}
