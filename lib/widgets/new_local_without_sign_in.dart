import 'package:flutter/material.dart';

class NewLocalWithoutSignIn extends StatelessWidget {
  const NewLocalWithoutSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/game/local'),
        child: Text("New Local Game"),
      ),
    );
  }
}
