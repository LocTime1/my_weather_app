// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/model/last_data.dart';
import 'package:my_weather_app/models/weather_forecast.dart';
import 'package:my_weather_app/widgets/city_view.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  Future<WeatherForecast>? forecastData;
  HomeScreen({super.key, this.forecastData});
  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  late Future<WeatherForecast> forecast;
  late Future<LastData?> myFutureLastData;
  late LastData? myLastData;
  String? city;

  @override
  void initState() async {
    super.initState();
    print(1234);
    if (widget.forecastData != null) {
      print(12345);
      forecast = Future.value(widget.forecastData);
      myLastData = await DBProvider.db.getLastData();
      print(myLastData);
      print("AAAA");
      if (myLastData != null) {
        print("Хуй");
      }
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
            Divider(
              color: Colors.black,
              indent: 15,
              endIndent: 15,
              thickness: 0.4,
            ),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: forecast,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // if (snapshot.data?[1] == null) {
                          //   DBProvider.db.insertData(LastData(
                          //       lat: snapshot.data![0].location!.lat,
                          //       long: snapshot.data![0].location!.lon,
                          //       city: translateToRussian(
                          //               snapshot.data[0]!.location!.name)
                          //           .then((val) {
                          //         return val;
                          //       }),
                          //       country: snapshot.data!.location!.country));
                          // }
                          return CityView(
                            snapshot: snapshot,
                            lastData: DBProvider.db.getLastData(),
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

  Future<String> translateToRussian(String sourceText) async {
    print('AAA');
    final translator = GoogleTranslator();
    var textOnRussian =
        await translator.translate(sourceText, from: 'en', to: 'ru');
    print(textOnRussian.text);
    return textOnRussian.text;
  }
}
