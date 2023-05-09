import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/grid_redirect_button.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inviteController = get<InviteService>();

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
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: inviteController.invites,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error occurred");
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.data!.exists) {
                    return const Text("Data does not exist");
                  }

                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Text(
                      "Invite from: ${data['inviteFrom']} Valid until: ${data['validUntil']}");
                },
              ),
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
