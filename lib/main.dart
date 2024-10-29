import 'package:flutter/material.dart';
import 'package:my_weather_app/screens/location_screen.dart';


void main() async {
   runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen()
    );
  }
}

