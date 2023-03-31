import 'package:flutter/material.dart';

class StatisticsRow extends StatelessWidget {
  final name;
  final value;

  const StatisticsRow({Key? key, this.name, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value),
        ],
      ),
    );
  }
}
