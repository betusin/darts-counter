import 'package:dartboard/board/dart_board.dart';
import 'package:dartboard/pages/local_game.dart';
import 'package:dartboard/pages/online_game.dart';
import 'package:dartboard/pages/settings.dart';
import 'package:dartboard/widgets/icon_text_button.dart';
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
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildButtons(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: const [
          GridRedirectButton(
              pageToRedirect: LocalGame(),
              text: "New Local Game",
              iconData: Icons.add_box_outlined),
          GridRedirectButton(
              pageToRedirect: OnlineGame(),
              text: "New Online Game",
              iconData: Icons.add_box),
          GridRedirectButton(
              pageToRedirect: Settings(),
              text: "Settings",
              iconData: Icons.settings),
          GridRedirectButton(
              pageToRedirect: DartBoard(),
              text: "Exit App",
              iconData: Icons.exit_to_app),
        ],
      ),
    );
  }
}
