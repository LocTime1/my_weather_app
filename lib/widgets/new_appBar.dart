// ignore_for_file: prefer_const_constructors
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/constans.dart';
import 'package:my_weather_app/db/database.dart';
import 'package:my_weather_app/screens/home_screen.dart';
import 'package:my_weather_app/screens/location_screen.dart';
import 'package:page_transition/page_transition.dart';

class NewAppbar extends StatefulWidget {
  const NewAppbar({super.key});

  @override
  State<NewAppbar> createState() => _NewAppbarState();
}

class _NewAppbarState extends State<NewAppbar> {
  late String lang;
  @override
  void initState() {
    setState(() {
      lang = "ru";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: DBProvider.db.getLastData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _city = snapshot.data!.city!;
            return Container(
              // color: Colors.green,
              width: size,
              child: GestureDetector(
                onTap: () {
                  showTopModal(context, height, size, _city);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size * 0.08,
                    ),
                    Image.asset(
                      "assets/icons/Location.png",
                      height: height * 0.033,
                    ),
                    Container(
                      width: size * 0.31883,
                      height: height * 0.0338,
                      child: AutoSizeText(
                        maxLines: 1,
                        "$_city",
                        style: TextStyle(
                            color: Colors.white, fontSize: size * 0.07),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  void showTopModal(BuildContext context, double h, double width, String city) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // позволяет контролировать высоту
      backgroundColor: Colors.transparent, // прозрачный фон
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: h * 0.56),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/mini_screen.png"))),
            height: h * 0.3784,
            width: width * 0.6626,
            padding: EdgeInsets.all(16.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/Location.png",
                        height: h * 0.033,
                      ),
                      SizedBox(
                        width: width * 0.28883,
                        height: h * 0.0338,
                        child: AutoSizeText(
                          "$city",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.07),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: const Color.fromRGBO(5, 86, 166, 69),
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          print(lang);
                          if (lang == 'ru') {
                            setState(() {
                              lang = "en";
                            });
                          } else {
                            setState(() {
                              lang = "ru";
                            });
                          }
                          Navigator.pop(context, true);
                          showTopModal(context, h, width, city);
                        },
                        icon: Image.asset(
                          lang == 'ru'
                              ? "assets/icons/russia.png"
                              : "assets/icons/en.png",
                          width: 25,
                          color: Colors.white,
                        )),
                    Container(
                        width: 190,
                        child: DropSearch(
                          lang: lang,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Мои любимые города:",
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  height: 100,
                  child: FutureBuilder(
                      future: DBProvider.db.getFewLastData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> data = snapshot.data!;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var item = data[index];
                                return Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        var _forecast = WeatherApi()
                                            .fetchWeather(item.toLowerCase());
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.size,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: HomeScreen(
                                                  forecastData: _forecast,
                                                )));
                                      },
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "или",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    bool? need = true;
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: LocationScreen(need)));
                  },
                  child: Container(
                    width: 250,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "Определить моё местоположение",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DropSearch extends StatefulWidget {
  final String lang;

  const DropSearch({super.key, required this.lang});

  @override
  State<DropSearch> createState() => _DropSearchState();
}

class _DropSearchState extends State<DropSearch> {
  late List<String> items;
  String? selectedValue;

  @override
  void initState() {
    items = widget.lang == "ru" ? russian_cities : all_cities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return items.where((item) =>
            item.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (String option) => option, // Возвращаем строку
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              // Используем InkWell для отклика на тапы
              onTap: () {
                onSelected(options.elementAt(index));
              },
              child: Container(
                padding: const EdgeInsets.all(16), // Добавляем отступы
                child: // Отступ между иконкой и заголовком
                    Text(options.elementAt(index),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            );
          },
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Введите город',
            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          style: TextStyle(fontSize: 16, color: Colors.white),
          cursorColor: Colors.blue,
        );
      },
      // displayStringForOption: (String option) => option,
      onSelected: (String selection) {
        setState(() {
          selectedValue = selection;
          var _forecast = WeatherApi().fetchWeather(selection.toLowerCase());
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.bottomCenter,
                  child: HomeScreen(
                    forecastData: _forecast,
                  )));
        });
      },
    );
  }
}
