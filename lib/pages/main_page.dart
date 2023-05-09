import 'package:dartboard/widgets/grid_redirect_button.dart';
import 'package:flutter/material.dart';

import '../widgets/profile/profile_bar.dart';

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
            routeName: "/game/local",
            text: "New Local Game",
            iconData: Icons.add_box_outlined,
          ),
          GridRedirectButton(
            routeName: "/game/online/start",
            text: "New Online Game",
            iconData: Icons.add_box,
          ),
          GridRedirectButton(
            routeName: "/settings",
            text: "Settings",
            iconData: Icons.settings,
          ),
          GridRedirectButton(
            routeName: "/exit",
            text: "Exit App",
            iconData: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }
}
