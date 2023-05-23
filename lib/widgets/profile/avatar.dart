import 'package:dartboard/service/setup_user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../service/ioc_container.dart';
import '../handlers/handling_future_builder.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = get<SetupUserService>();

    return TextButton(
      onPressed: () => {context.push('/profile')},
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: HandlingFutureBuilder(
            future: userController.getUserHashOfCurrentUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data,
                  style: TextStyle(color: Colors.blue),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
