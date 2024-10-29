// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements


import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/model/last_data.dart';
import 'package:my_weather_app/screens/home_screen.dart';

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


   
    print(123);
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    var _forecast = WeatherApi()
        .fetchWeather('${_locationData.latitude},${_locationData.longitude}');
    // var _forecast = WeatherApi().fetchWeather("London");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
        forecastData: _forecast,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 60, 193, 255),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
