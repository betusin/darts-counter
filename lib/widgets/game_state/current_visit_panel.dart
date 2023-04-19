import 'package:flutter/material.dart';

class CurrentVisitPanel extends StatelessWidget {

  final String first;
  final String second;
  final String third;
  final bool isBusted;

  const CurrentVisitPanel({super.key, required this.first, required this.second, required this.third, required this.isBusted});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScoreContainer(first),
        _buildScoreContainer(second),
        _buildScoreContainer(third)
      ],
    );
  }
  
  Widget _buildScoreContainer(String text) {
    return Container(
      alignment: Alignment.center,
      width: 55,
      height: 70,
      color: Colors.black,
      child: Text(text,
        style: TextStyle(
          color: isBusted ? Colors.red : Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
