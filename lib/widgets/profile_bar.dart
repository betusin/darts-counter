import 'package:dartboard/pages/statistics_page.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Avatar(name: name, surname: surname),
            _buildStatisticsButton(context),
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

  TextButton _buildStatisticsButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return TextButton(
      onPressed: () {
        final pageToPush = MaterialPageRoute(builder: (_) => StatisticsPage());
        Navigator.of(context).push(pageToPush);
      },
      child: Column(
        children: [
          Icon(
            Icons.align_vertical_bottom_rounded,
            color: color,
            size: 36,
          ),
          Text(
            "Statistics",
            style: TextStyle(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
