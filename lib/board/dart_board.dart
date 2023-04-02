import 'package:dartboard/board/border_painter.dart';
import 'package:dartboard/board/bullseye.dart';
import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/inner_segments.dart';
import 'package:dartboard/board/double_segments.dart';
import 'package:dartboard/board/score_label.dart';
import 'package:dartboard/board/triple_segments.dart';
import 'package:dartboard/board/zero_segment.dart';
import 'package:flutter/material.dart';

class DartBoard extends StatelessWidget {
  const DartBoard({super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(child: Container()),
        ScoreLabel(),
        Expanded(child: Container()),
        Center(
            child: CustomPaint(
          foregroundPainter: BorderPainter(radius: (widthOfScreen - boardFromSideOffset) / 2),
          child: RepaintBoundary(
            // repaint boundary so BorderPainter isn't called everytime other widget is repainting
            child: Stack(alignment: Alignment.center, children: [
              ZeroSegment(widthOfWholeBoard: widthOfScreen),
              DoubleSegments(widthOfWholeBoard: widthOfScreen - boardFromSideOffset),
              TripleSegments(widthOfWholeBoard: widthOfScreen - boardFromSideOffset),
              InnerSegments(widthOfWholeBoard: widthOfScreen - boardFromSideOffset),
              BullsEye(),
            ]),
          ),
        )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
