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
    double widthOfScreen = MediaQuery.of(context).size.width - 4;
    return Scaffold(
      appBar: AppBar(title: Text('Dart board')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            ScoreLabel(),
            Expanded(child: Container()),
            Center(
                child: CustomPaint(
                  foregroundPainter: BorderPainter(),
                  child: RepaintBoundary(  // repaint boundary so BorderPainter isn't called everytime other widget is repainting
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DoubleSegments(widthOfScreen: widthOfScreen),
                        TripleSegments(widthOfScreen: widthOfScreen),
                        InnerSegments(widthOfScreen: widthOfScreen),
                        BullsEye(),
                      ]
                    ),
                  ),
                )
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
