import 'package:dartboard/board/highlighting_button.dart';
import 'package:dartboard/board/segment_clipper.dart';
import 'package:flutter/material.dart';

class Segment extends StatelessWidget {
  final double widthOfScreen;
  final Color color;
  final double size;
  final int offset;
  final int value;
  final bool isDouble;

  const Segment(
      {super.key,
      required this.widthOfScreen,
      required this.color,
      required this.size,
      required this.offset,
      required this.value,
      this.isDouble = false});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SegmentClipper(widthOfWholeBoard: widthOfScreen, offset: offset),
      child: Container(
        height: size,
        width: size,
        child: HighlightingButton(backgroundColor: color, value: value, isDouble: isDouble,),
      ),
    );
  }
}
