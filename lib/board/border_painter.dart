import 'dart:math';

import 'package:dartboard/board/constants.dart';
import 'package:dartboard/board/segment_value_mapper.dart';
import 'package:flutter/material.dart';

/*
This custom painter paints stuff on top of the dart board:
- circle borders between segments
- double and triple text on top
- numbers around the board
 */
class BorderPainter extends CustomPainter {
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  final double radius;

  BorderPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(
        size.width / 2,
        size.height /
            2); //canvas coordinates translated so 0,0 is in the middle

    Paint paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset.zero, radius, paint); //outer border
    canvas.drawCircle(Offset.zero, radius - tripleSegmentOffset / 2,
        paint); //between double and triple
    canvas.drawCircle(Offset.zero, radius - innerSegmentOffset / 2,
        paint); // between single and triple
    canvas.drawCircle(
        Offset.zero, outerBullsEyeDiameter / 2, paint); // around outer bullseye
    canvas.drawCircle(
        Offset.zero, bullsEyeDiameter / 2, paint); //around inner bullseye

    //texts "double" and "triple" in the upper segment
    _textPainter.text = TextSpan(text: 'DOUBLE', style: textInsideBoardStyle);
    _textPainter.layout();
    _textPainter.paint(canvas,
        Offset(-_textPainter.width / 2, -radius + textFromCircleOffset));

    _textPainter.text = TextSpan(text: 'TRIPLE', style: textInsideBoardStyle);
    _textPainter.layout();
    _textPainter.paint(
        canvas,
        Offset(-_textPainter.width / 2,
            -radius + (tripleSegmentOffset / 2) + textFromCircleOffset));

    //numbers around the board
    const double rotation = 18 * pi / 180; //18 degrees translated to radians

    for (int i = 0; i < 20; i++) {
      Color col = (i % 2 == 0)
          ? Colors.white
          : Colors.black; //black/white depending on segment color
      _textPainter.text = TextSpan(
          text: segmentValueMapper[((i - 5) % 20) + 1]
              .toString(), //little magic to translate index into segment number
          style: textInsideBoardStyle.copyWith(color: col, fontSize: 15));
      _textPainter.layout();
      _textPainter.paint(
          canvas,
          Offset(-_textPainter.width / 2,
              -radius + (innerSegmentOffset / 2) + textFromCircleOffset));
      canvas.rotate(rotation); //rotating canvas 18 degrees clockwise
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
