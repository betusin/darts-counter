import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final textName;
  final textValue;
  const TextRow(this.textName, this.textValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textName,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(
          width: 10,
        ),
        Text(textValue)
      ],
    );
  }
}
