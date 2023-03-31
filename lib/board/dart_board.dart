import 'package:dartboard/board/border_painter.dart';
import 'package:dartboard/board/bullseye.dart';
import 'package:dartboard/board/inner_segments.dart';
import 'package:dartboard/board/double_segments.dart';
import 'package:dartboard/board/score_label.dart';
import 'package:dartboard/board/triple_segments.dart';
import 'package:flutter/material.dart';

class DartBoard extends StatelessWidget {
  const DartBoard({super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfBoard = MediaQuery.of(context).size.width - 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Expanded(child: Container()),
          ScoreLabel(),
          Expanded(child: Container()),
          Center(
              child: CustomPaint(
            foregroundPainter: BorderPainter(),
            child: RepaintBoundary(
              // repaint boundary so BorderPainter isn't called everytime other widget is repainting
              child: Stack(alignment: Alignment.center, children: [
                DoubleSegments(widthOfWholeBoard: widthOfBoard),
                TripleSegments(widthOfWholeBoard: widthOfBoard),
                InnerSegments(widthOfWholeBoard: widthOfBoard),
                BullsEye(),
              ]),
            ),
          )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
