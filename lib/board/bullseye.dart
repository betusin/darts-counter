import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/highlighting_button.dart';
import 'package:flutter/material.dart';

class BullsEye extends StatelessWidget {
  const BullsEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: outerBullsEyeDiameter,
          width: outerBullsEyeDiameter,
          child: HighlightingButton(
              backgroundColor: dartboardGreen, value: 25, isCircle: true),
        ),
        Container(
          height: bullsEyeDiameter,
          width: bullsEyeDiameter,
          child: HighlightingButton(
              backgroundColor: dartboardRed,
              value: 50,
              isCircle: true,
              isDouble: true),
        ),
      ],
    );
  }
}
