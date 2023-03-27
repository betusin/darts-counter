import 'dart:math';

import 'package:flutter/cupertino.dart';

class SegmentClipper extends CustomClipper<Path> {

  final double widthOfWholeBoard;
  final int offset;

  double _x1 = 0.0;
  double _y1 = 0.0;
  double _x2 = 0.0;
  double _y2 = 0.0;

  SegmentClipper({required this.widthOfWholeBoard, required this.offset});

  @override
  Path getClip(Size size) {

    double radius = size.height / 2;

    _calculateCorners(radius);

    Path path = Path()
      ..moveTo(radius, radius) //move to middle of rect
      ..lineTo(_x1, _y1)  //line to left corner
      ..arcToPoint(Offset(_x2, _y2), radius: Radius.circular(widthOfWholeBoard)) //arc to right corner
      ..lineTo(radius, radius) //line back to middle
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  void _calculateCorners(double radius){
    //angles of corners in radians
    double angleLeft = (offset * 18 - 9) * pi / 180;
    double angleRight = (( offset + 1 ) * 18 - 9) * pi / 180;

    _x1 = radius + radius * cos(angleLeft);
    _y1 = radius + radius * sin(angleLeft);

    _x2 = radius + radius * cos(angleRight);
    _y2 = radius + radius * sin(angleRight);
  }


}