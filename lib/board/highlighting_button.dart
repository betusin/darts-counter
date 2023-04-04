import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/current_score_notifier.dart';
import 'constants.dart';

class HighlightingButton extends StatelessWidget {

  final Color backgroundColor;
  final int value;
  final bool isCircle;

  const HighlightingButton({super.key, required this.backgroundColor, required this.value, this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.read<CurrentScoreNotifier>();
    return ElevatedButton(
      style: ButtonStyle(
        shape: isCircle ? MaterialStateProperty.all(CircleBorder()) : null,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return highlightYellow;
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        currentScore.setScore(value);
      },
      child: null,
    );
  }
}
