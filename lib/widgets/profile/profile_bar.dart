import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/widgets/handlers/handling_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../service/ioc_container.dart';
import 'avatar.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({Key? key}) : super(key: key);

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
            HandlingFutureBuilder(
              future: userController.getUserHashOfCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Avatar(userHash: snapshot.data);
              },
            ),
            _buildStatisticsButton(context),
          ],
        ),
      ),
    );
  }

  TextButton _buildStatisticsButton(BuildContext context) {
    final color = Theme.of(context).colorScheme.onBackground;
    return TextButton(
      onPressed: () => context.push("/statistics"),
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
