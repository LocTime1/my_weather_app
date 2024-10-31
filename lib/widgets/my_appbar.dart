// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:my_weather_app/models/last_data.dart';

class MyAppbar extends StatelessWidget {
  final Future<LastData?> lastData;
  final _textEditingController = TextEditingController();
  MyAppbar({required this.lastData});
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Future<String?> city = lastData.then((res) => res!.city);
    return FutureBuilder(
        future: city,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _city = snapshot.data!;
            return Container(
              // color: Colors.green,
              width: size,
              margin: EdgeInsets.only(
                  right: size * 0.03, top: height * 0.005, left: size * 0.03),
              child: Row(
                children: [
                  Container(
                    width: size * 0.335,
                    height: height * 0.026,
                    child: GFButton(
                      onPressed: () {
                        print("Кнопка нажата");
                      },
                      color: Colors.transparent,
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      shape: GFButtonShape.pills,
                      icon: Image.asset(
                        "assets/icons/my_location.png",
                        width: size * 0.056,
                      ),
                      text: "Определить моё\n местоположение",
                      textStyle: TextStyle(
                          fontSize: size * 0.025, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: size * 0.35,
                    height: height * 0.026,
                    child: TextField(
                      maxLines: 1,
                      controller: _textEditingController,
                      textAlignVertical: TextAlignVertical.center,
                      style:
                          TextStyle(fontSize: 15, overflow: TextOverflow.clip),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            "assets/icons/loupe.png",
                          ),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: height * 0.023),
                        hintText: "Введите город",
                        hintStyle: TextStyle(fontSize: height * 0.01),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      _city,
                      style: TextStyle(fontSize: size * 0.05),
                      minFontSize: 1,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
