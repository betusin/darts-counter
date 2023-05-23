import 'package:dartboard/widgets/profile/avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
