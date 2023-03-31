import 'package:dartboard/board/dart_board.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          children: [
            ProfileBar(
              name: "John",
              surname: "Doe",
            ),
            TextButton(
                onPressed: () {
                  final pageToPush =
                      MaterialPageRoute(builder: (_) => DartBoard());
                  Navigator.of(context).push(pageToPush);
                },
                child: Text("New Local Game")),
            TextButton(onPressed: () {}, child: Text("New Online Game")),
            TextButton(onPressed: () {}, child: Text("Settings")),
            TextButton(onPressed: () {}, child: Text("Exit App")),
          ],
        ),
      ),
    );
  }
}
