import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

class TripleSegments extends StatelessWidget {
  final double widthOfWholeBoard;

  TripleSegments({super.key, required this.widthOfWholeBoard});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildInnerSegments(context),
    );
  }

  List<Widget> _buildInnerSegments(BuildContext context) {
    List<Segment> segments = [];

    for (int i = 0; i < 20; i++) {
      Color col = (i % 2 == 0)
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary;

      segments.add(Segment(
          widthOfScreen: widthOfWholeBoard,
          color: col,
          size: widthOfWholeBoard - tripleSegmentOffset,
          offset: i,
          value: segmentValueMapper[i + 1]! * 3));
    }
    return segments;
  }
}
