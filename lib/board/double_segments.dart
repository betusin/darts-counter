import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

class DoubleSegments extends StatelessWidget {
  final double widthOfWholeBoard;

  DoubleSegments({super.key, required this.widthOfWholeBoard});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildOuterSegments(),
    );
  }

  List<Widget> _buildOuterSegments() {
    List<Segment> segments = [];

    for (int i = 0; i < 20; i++) {
      segments.add(Segment(
        widthOfScreen: widthOfWholeBoard,
        color: (i % 2 == 0) ? dartboardGreen : dartboardRed,
        size: widthOfWholeBoard,
        offset: i,
        value: segmentValueMapper[i + 1]! * 2,
        isDouble: true,
      ));
    }
    return segments;
  }
}
