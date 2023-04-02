import 'package:dartboard/board/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/current_score_notifier.dart';

class ZeroSegment extends StatelessWidget {
  final double widthOfWholeBoard;

  const ZeroSegment({super.key, required this.widthOfWholeBoard});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.read<CurrentScoreNotifier>();
    return Container(
      height: widthOfWholeBoard,
      width: widthOfWholeBoard,
      child: ElevatedButton(
          onPressed: () {currentScore.setScore(0);},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(dartboardBackground),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return highlightYellow;
                }
                return null;
              },
            ),
          ),
          child: null
      ),
    );
  }
}
