import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.8],
      colors: <Color>[
        Color(0xff2E305F),
        Color(0xff202333),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(decoration: boxDecoration),
      Positioned(
        top: -100,
        left: -30,
        child: _PinkBox(),
      ),
    ]);
  }
}

class _PinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(150, 98, 188, 1),
                Color.fromRGBO(50, 142, 172, 1),
              ],
            )),
      ),
    );
  }
}
