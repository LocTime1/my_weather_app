// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/db/database.dart';
// import 'package:my_weather_app/screens/home_screen.dart';
// import 'package:my_weather_app/screens/location_screen.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class NewAppBar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/Location.png",
                      height: height * 0.033,
                    ),
                    SizedBox(
                      width: size * 0.28883,
                      height: height * 0.0338,
                      child: AutoSizeText(
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

  // void showTopModal(BuildContext context) {
  //   WoltModalType.
  //   showDialog(context: context, builder: (context, controll))
  // }
}
