// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/widgets/main_info.dart';
import 'package:my_weather_app/widgets/my_appbar.dart';

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
      body: Container(
        // color: Color.fromARGB(255, 60, 193, 255),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: forecast,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              MyAppbar(lastData: DBProvider.db.getLastData()),
                              MainInfo(
                                snapshot: snapshot.data!,
                                lastData: DBProvider.db.getLastData(),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child: Container(
                            child: CircularProgressIndicator(),
                          ));
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
