import 'package:dartboard/board/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/current_score_notifier.dart';

class BullsEye extends StatelessWidget {
  const BullsEye({super.key});

  @override
  Widget build(BuildContext context) {
    final currentScore = context.read<CurrentScoreNotifier>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: outerBullsEyeDiameter,
          width: outerBullsEyeDiameter,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context).highlightColor;
                  }
                  return null;
                },
              ),
            ),
            onPressed: () {
              currentScore.setScore(25);
            },
            child: null,
          ),
        ),
        Container(
          height: bullsEyeDiameter,
          width: bullsEyeDiameter,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context).highlightColor;
                  }
                  return null;
                },
              ),
            ),
            onPressed: () {
              currentScore.setScore(50);
            },
            child: null,
          ),
        ),
      ],
    );
  }
}
