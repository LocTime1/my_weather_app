// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocScreenState();
}

class _LocScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    Location location = Location();
    PermissionStatus? _permissionGranted;
    LocationData? _locationData;
    double? lat;
    double? long;

    print(123);
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var last = await DBProvider.db.getLastData();
    if (last == null) {
      print("Данных нет!");
      _locationData = await location.getLocation();
      lat = _locationData.latitude;
      long = _locationData.longitude;
    } else {
      print("Данные есть!");
      lat = last.lat;
      long = last.long;
    }
    var _forecast = WeatherApi().fetchWeather('${lat},${long}');

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: HomeScreen(
              forecastData: _forecast,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
