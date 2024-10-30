import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.07,
          top: 140,
          left: MediaQuery.of(context).size.width * 0.07),
      child: Row(
        children: [
          GFButton(
            onPressed: () {},
            color: Colors.black,
            child: Container(
              color: Colors.yellow,
              child: Row(
                children: [
                  Image.asset("assets/icons/my_location.png"),
                  Text(
                    "AAAAAAAAA",
                    style: TextStyle(fontSize: 5),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
