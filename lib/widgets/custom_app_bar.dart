import 'package:dartboard/widgets/profile/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String STATISTICS_LOCATION = '/statistics';

class CustomAppBar extends AppBar {
  final Widget title;
  final BuildContext context;

  CustomAppBar({
    Key? key,
    required this.title,
    required this.context,
  }) : super(
          key: key,
          title: title,
          actions: [
            if (GoRouter.of(context).location != STATISTICS_LOCATION &&
                FirebaseAuth.instance.currentUser != null)
              IconButton(
                onPressed: () {
                  context.push(STATISTICS_LOCATION);
                },
                icon: const Icon(
                  Icons.align_vertical_bottom_rounded,
                  size: 36,
                ),
              ),
            if (FirebaseAuth.instance.currentUser != null) Avatar(),
          ],
        );
}
