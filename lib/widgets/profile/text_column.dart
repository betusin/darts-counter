import 'package:flutter/material.dart';

class TextColumn extends StatelessWidget {
  final textName;
  final textValue;
  const TextColumn(this.textName, this.textValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
