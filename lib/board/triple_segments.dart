import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

class TripleSegments extends StatelessWidget {

  final double widthOfScreen;

  TripleSegments({super.key, required this.widthOfScreen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      _buildInnerSegments()
      ,
    );
  }

  List<Widget> _buildInnerSegments(){
    List<Segment> segments = [];

    for (int i = 0; i < 20; i++){
      Color col = (i%2 == 0) ? dartboardGreen : dartboardRed;
      segments.add(Segment(
          widthOfScreen: widthOfScreen,
          color: col,
          size: widthOfScreen - tripleSegmentOffset,
          offset: i,
          value: segmentValueMapper[i+1]! * 3));
    }
    return segments;
  }
}