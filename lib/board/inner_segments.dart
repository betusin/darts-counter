import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

class InnerSegments extends StatelessWidget {
  final double widthOfWholeBoard;

  InnerSegments({super.key, required this.widthOfWholeBoard});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildInnerSegments(),
    );
  }

  List<Widget> _buildInnerSegments() {
    List<Segment> segments = [];

    for (int i = 0; i < 20; i++) {
      Color col = (i % 2 == 0) ? dartboardWhite : dartboardBlack;
      segments.add(Segment(
          widthOfScreen: widthOfWholeBoard,
          color: col,
          size: widthOfWholeBoard - innerSegmentOffset,
          offset: i,
          value: segmentValueMapper[i + 1]!));
    }
    return segments;
  }
}
