import 'package:dartboard/widgets/text_row.dart';
import 'package:flutter/material.dart';

import 'avatar.dart';

class ProfileBar extends StatelessWidget {
  final name;
  final surname;

  const ProfileBar({Key? key, this.name, this.surname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Avatar(name: name, surname: surname),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextRow("Name", name),
                TextRow("Surname", surname),
              ],
            )
          ],
        ),
      ),
    );
  }
}
