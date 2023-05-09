import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/grid_redirect_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            _buildInvites(context),
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

  Expanded _buildInvites(
    BuildContext context,
  ) {
    final inviteController = get<InviteService>();

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: inviteController.invites,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error occurred");
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.separated(
            itemBuilder: (context, index) {
              return _buildInvite(docs[index].data());
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: docs.length,
          );
        },
      ),
    );
  }

  Widget _buildInvite(Map<String, dynamic> data) {
    return Text(
        "Invite from: ${data['inviteFrom']} Valid until: ${_timestampToString(data['validUntil'])}");
  }

  String _timestampToString(Timestamp timestamp) {
    final DateFormat formatter = DateFormat('h:mm a');
    final String formatted = formatter.format(timestamp.toDate());
    return formatted;
  }
}
