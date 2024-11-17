// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class NewMainInfo extends StatefulWidget {
  const NewMainInfo({super.key});

  @override
  State<NewMainInfo> createState() => _NewMainInfoState();
}

class _NewMainInfoState extends State<NewMainInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SemiCircleContainer(
      width: 300,
      height: 200,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Контейнер с вырезом',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ));
  }
}

class SemiCircleContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget? child;

  const SemiCircleContainer({
    Key? key,
    required this.width,
    required this.height,
    this.color = Colors.blue,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipper:
      //     SemiCircleClipper(), // Используем SemiCircleClipper из flutter_custom_clippers
      child: Container(
        width: width,
        height: height,
        color: color,
        child: child,
      ),
    );
  }
}
