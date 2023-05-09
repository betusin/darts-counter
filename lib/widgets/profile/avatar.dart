import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _AVATAR_SIZE = 50.0;

class Avatar extends StatelessWidget {
  final String name;
  final String surname;

  const Avatar({super.key, required this.name, required this.surname});

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
            '${_getInitialFromString(name)}${_getInitialFromString(surname)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  String _getInitialFromString(String input) => input.isEmpty ? '' : input[0];
}
