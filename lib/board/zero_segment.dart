import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/highlighting_button.dart';
import 'package:flutter/material.dart';

class ZeroSegment extends StatelessWidget {
  final double widthOfWholeBoard;

  const ZeroSegment({super.key, required this.widthOfWholeBoard});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widthOfWholeBoard,
      width: widthOfWholeBoard,
      child: HighlightingButton(backgroundColor: dartboardBackground, value: 0),
    );
  }
}
