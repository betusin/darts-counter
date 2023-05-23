import 'package:dartboard/widgets/profile/avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            IconButton(
                onPressed: () {
                  context.push('/statistics');
                },
                icon: const Icon(
                  Icons.align_vertical_bottom_rounded,
                  size: 36,
                )),
            Avatar(),
          ],
        );
}
