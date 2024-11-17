// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class LocationScreen extends StatefulWidget {
  final bool? need_find_location;
  LocationScreen([this.need_find_location]);

  @override
  State<LocationScreen> createState() => _LocScreenState();
}

class _LocScreenState extends State<LocationScreen> {
  bool? _need_find_location;
  @override
  void initState() {
    _need_find_location = widget.need_find_location;
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    double? lat;
    double? long;
    if (_need_find_location != null) {
      Location location = Location();
      PermissionStatus? _permissionGranted;
      LocationData? _locationData;

      print(123);
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      lat = _locationData.latitude;
      long = _locationData.longitude;
    } else {
      var last = await DBProvider.db.getLastData();
      lat = last!.lat;
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
