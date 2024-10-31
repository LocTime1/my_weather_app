// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.green,
      width: width,
      margin:
          EdgeInsets.only(right: width * 0.07, top: 140, left: width * 0.07),
      child: Row(
        children: [
          Container(
            width: width * 0.335,
            child: GFButton(
              onPressed: () {},
              color: Colors.transparent,
              borderSide: BorderSide(color: Colors.black, width: 1.0),
              shape: GFButtonShape.pills,
              icon: Image.asset(
                "assets/icons/my_location.png",
                width: width * 0.056,
              ),
              text: "Определить моё\n местоположение",
              textStyle: TextStyle(fontSize: width * 0.025),
              textColor: Colors.white,
              // child: Container(
              //   color: Colors.yellow,
              // child: Row(
              //   children: [
              //     Image.asset("assets/icons/my_location.png"),
              //     Text(
              //       "AAAAAAAAA",
              //       style: TextStyle(fontSize: 5),
              //     )
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
