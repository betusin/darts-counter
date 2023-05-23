import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RedirectGameButton extends StatelessWidget {
  final String location;
  final String text_game_mode;

  const RedirectGameButton(
      {Key? key, required this.location, required this.text_game_mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.push(location);
      },
      child: Text("Start $text_game_mode game"),
    );
  }
}
