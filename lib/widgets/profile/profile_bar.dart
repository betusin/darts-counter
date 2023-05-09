import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/widgets/profile/text_column.dart';
import 'package:flutter/material.dart';

import '../../service/ioc_container.dart';
import 'avatar.dart';

class ProfileBar extends StatelessWidget {
  final name;
  final surname;

  const ProfileBar({Key? key, this.name, this.surname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userController = get<SetupUserService>();

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Avatar(name: name, surname: surname),
            _buildStatisticsButton(context),
            FutureBuilder(
              future: userController.getUserHashOfCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error occurred");
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return TextColumn("User Hash", snapshot.data);
              },
            )
          ],
        ),
      ),
    );
  }

  TextButton _buildStatisticsButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, "/statistics"),
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
