// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/widgets/city_view.dart';

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
      appBar: AppBar(
        title: Text('Погода'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 60, 193, 255),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color.fromARGB(255, 60, 193, 255),
        child: Column(
          children: [
            Divider(color: Colors.black, indent: 15, endIndent: 15, thickness: 0.4,),
            Expanded(
            child: ListView(
              children: [
                FutureBuilder(
                    future: forecast,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CityView(snapshot: snapshot);
                      } else {
                        return Center(
                            child: Container(child: CircularProgressIndicator(),
                                ));
                      }
                    })
              ],
            ),
          )],
        ),
      ),
    );
  }
}
