// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:my_weather_app/API/weather_api.dart';
import 'package:my_weather_app/db/database.dart';
// import 'package:my_weather_app/screens/home_screen.dart';
// import 'package:my_weather_app/screens/location_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class NewAppBar extends StatelessWidget {
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
                  print("2222");

                  showTopModal(context, height, size, _city);
                  print("11111");
                },
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
              mainAxisSize: MainAxisSize.min,
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
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: Image.asset("assets/icons/Search.png"),
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

// class MyCustomBottomSheetType extends WoltBottomSheetType {
//   const MyCustomBottomSheetType()
//       : super(
//           shapeBorder: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(24))),
//           showDragHandle: false,
//           barrierDismissible: false,
//         );
// }
