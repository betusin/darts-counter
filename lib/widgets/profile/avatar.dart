import 'package:dartboard/service/setup_user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../service/ioc_container.dart';
import '../handlers/handling_future_builder.dart';

const _AVATAR_SIZE = 55.0;

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = get<SetupUserService>();

    return TextButton(
      onPressed: () => {context.push('/profile')},
      child: Container(
        width: _AVATAR_SIZE,
        height: _AVATAR_SIZE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: HandlingFutureBuilder(
            future: userController.getUserHashOfCurrentUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Text(
                snapshot.data,
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
