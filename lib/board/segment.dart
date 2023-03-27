import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment_clipper.dart';
import 'package:dartboard/current_score_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Segment extends StatelessWidget {

  final double widthOfScreen;
  final Color color;
  final double size;
  final int offset;
  final int value;

  const Segment({super.key, required this.widthOfScreen, required this.color, required this.size, required this.offset, required this.value});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.read<CurrentScoreNotifier>();
    return ClipPath(
      clipper: SegmentClipper(widthOfWholeBoard: widthOfScreen, offset: offset),
      child: Container(
        height: size,
        width: size,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return highlightYellow;
                }
                return null;
              },
            ),
          ),
          onPressed: (){currentScore.setScore(value);},
          child: null,
        ),
      ),
    );
  }
}
