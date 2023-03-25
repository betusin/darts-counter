import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

class DoubleSegments extends StatelessWidget {

  final double widthOfScreen;

  DoubleSegments({super.key, required this.widthOfScreen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
        _buildOuterSegments()
      ,
    );
  }

  List<Widget> _buildOuterSegments(){
   List<Segment> segments = [];

   for (int i = 0; i < 20; i++){
      Color col = (i%2 == 0) ? dartboardGreen : dartboardRed;
      segments.add(Segment(
        widthOfScreen: widthOfScreen,
        color: col,
        size: widthOfScreen,
        offset: i,
        value: segmentValueMapper[i+1]! * 2,));
   }
   return segments;
  }
}
