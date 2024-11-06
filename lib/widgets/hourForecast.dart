// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_weather_app/constans.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HourForecast extends StatefulWidget {
  final List<double> temp;
  final List<String> icons;
  final List<int> listIsDay;
  final String dateTime;
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
  int? currentIndex;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  late String hour;

  @override
  void initState() {
    temp = widget.temp;
    icons = widget.icons;
    listIsDay = widget.listIsDay;
    hour = widget.dateTime.split(" ")[1].split(":")[0];
    currentIndex = int.parse(hour) >= 1 ? int.parse(hour) - 1 : 0;
    itemPositionsListener.itemPositions.addListener(
      () => log(
          'Last index: ${itemPositionsListener.itemPositions.value.last.index}  first index: ${itemPositionsListener.itemPositions.value.last.index}'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(index: currentIndex!);
    });
    // scrollOffsetListener.changes.listen((event) => currentIndex);

    double height = MediaQuery.of(context).size.height;
    double size = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => {
              setState(() {
                _scrollController.scrollTo(
                    duration: Duration(seconds: 1),
                    index: itemPositionsListener
                                .itemPositions.value.first.index ==
                            currentIndex! - 1
                        ? itemPositionsListener
                                .itemPositions.value.first.index -
                            1
                        : itemPositionsListener.itemPositions.value.last.index -
                            1);
              })

              // setState(() {
              //   currentIndex = currentIndex! - 1;
              // })
            },
            child: Image.asset(
              "assets/icons/left.png",
              width: size * 0.065,
            ),
          ),
          Container(
            height: height * 0.1734,
            width: size * 0.87,
            alignment: Alignment.center,
            // margin: EdgeInsets.symmetric(horizontal: size * 0.045),
            child: ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              itemPositionsListener: itemPositionsListener,
              scrollOffsetListener: scrollOffsetListener,
              scrollOffsetController: scrollOffsetController,
              scrollDirection: Axis.horizontal,
              itemCount: 24,
              padding: EdgeInsets.only(
                  left: size * 0.03, right: size * 0.03, bottom: height * 0.01),
              itemBuilder: (context, index) {
                return MyListTile(
                    temp: temp,
                    icons: icons,
                    listIsDay: listIsDay,
                    hour: hour,
                    index: index);
              },
            ),
          ),
          Image.asset("assets/icons/right.png", width: size * 0.065),
        ],
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final List<double> temp;
  final List<String> icons;
  final List<int> listIsDay;
  final String hour;
  final int index;

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
          width: size * 0.221,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/mini_night.png"),
              ),
              boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(0, 3))]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                listIsDay[index] == 1
                    ? day_icon[icons[index]]!
                    : night_icon[icons[index]]!,
                width: size * 0.1238,
              ),
              SizedBox(
                height: height * 0.0625,
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 1,
                  "${temp[index].round()}°",
                  style: TextStyle(fontSize: size * 0.2, color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.0286,
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 1,
                  "$index:00",
                  style: TextStyle(fontSize: size * 0.045, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: size * 0.01699,
        )
      ]);
    } else {
      return Row(children: [
        Container(
          width: size * 0.221,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/night_sky.jpg"),
              ),
              boxShadow: const [
                BoxShadow(blurRadius: 4, offset: Offset(0, 3))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                listIsDay[index] == 1
                    ? day_icon[icons[index]]!
                    : night_icon[icons[index]]!,
                width: size * 0.1238,
              ),
              SizedBox(
                height: height * 0.0625,
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 1,
                  "${temp[index].round()}°",
                  style: TextStyle(fontSize: size * 0.2, color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.0286,
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 1,
                  "$index:00",
                  style: TextStyle(fontSize: size * 0.045, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: size * 0.01699,
        )
      ]);
    }
  }
}
