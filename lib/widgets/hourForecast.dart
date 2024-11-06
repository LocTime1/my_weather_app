// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_weather_app/constans.dart';
import 'package:stream_chat_flutter/scrollable_positioned_list/src/scrollable_positioned_list.dart';

class HourForecast extends StatefulWidget {
  List<double> temp;
  List<String> icons;
  List<int> listIsDay;
  String dateTime;
  HourForecast(
      {super.key,
      required this.temp,
      required this.icons,
      required this.listIsDay,
      required this.dateTime});

  @override
  State<HourForecast> createState() => _HourForecastState();
}

class _HourForecastState extends State<HourForecast> {
  late List<double> temp;
  late List<String> icons;
  late List<int> listIsDay;
  final ItemScrollController _scrollController = ItemScrollController();
  late String hour;

  @override
  void initState() {
    temp = widget.temp;
    icons = widget.icons;
    listIsDay = widget.listIsDay;
    hour = widget.dateTime.split(" ")[1].split(":")[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
          index: int.parse(hour) >= 2 ? int.parse(hour) - 2 : 0);
    });
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      alignment: Alignment.center,
      child: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        padding: EdgeInsets.only(
            top: height * 0.01,
            left: size * 0.03,
            right: size * 0.03,
            bottom: height * 0.01),
        itemBuilder: (context, index) {
          return MyListTile(
              temp: temp,
              icons: icons,
              listIsDay: listIsDay,
              hour: hour,
              index: index);
        },
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  List<double> temp;
  List<String> icons;
  List<int> listIsDay;
  String hour;
  int index;

  MyListTile(
      {super.key,
      required this.temp,
      required this.icons,
      required this.listIsDay,
      required this.hour,
      required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    if (index != int.parse(hour)) {
      return Row(children: [
        Container(
          width: size * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/night_sky.jpg"),
                  opacity: 0.5),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)]),
          child: Column(
            children: [
              Image.asset(
                listIsDay[index] == 1
                    ? day_icon[icons[index]]!
                    : night_icon[icons[index]]!,
                height: height * 0.08,
              ),
              Text(
                "${temp[index].round()}°",
                style: TextStyle(fontSize: size * 0.09, color: Colors.white),
              ),
              Text(
                "$index:00",
                style: TextStyle(fontSize: size * 0.045, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        )
      ]);
    } else {
      return Row(children: [
        Container(
          width: size * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/night_sky.jpg"),
              ),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)]),
          child: Column(
            children: [
              Image.asset(
                listIsDay[index] == 1
                    ? day_icon[icons[index]]!
                    : night_icon[icons[index]]!,
                height: height * 0.08,
              ),
              Text(
                "${temp[index].round()}°",
                style: TextStyle(fontSize: size * 0.09, color: Colors.white),
              ),
              Text(
                "$index:00",
                style: TextStyle(fontSize: size * 0.045, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        )
      ]);
    }
  }
}
