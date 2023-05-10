import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _AVATAR_SIZE = 55.0;

class Avatar extends StatelessWidget {
  final String userHash;

  const Avatar({super.key, required this.userHash});

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            userHash,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
