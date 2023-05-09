import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/invite_from_list_item.dart';
import 'package:flutter/material.dart';

import '../widgets/invite_list_item.dart';

class OnlineGameStartPage extends StatelessWidget {
  var inviteController = get<InviteService>();

  OnlineGameStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Invite your friends"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () {
                inviteController.sendInvite(textController.value.text);
                textController.clear();
              },
              child: Text("Invite friend"),
            ),
            Divider(),
            Text(
              "Invites to You",
              style: TextStyle(fontSize: 20),
            ),
            _buildInvitesToYou(context),
            Text(
              "Invites from You",
              style: TextStyle(fontSize: 20),
            ),
            _buildInvitesFromYou(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildInvitesToYou(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: inviteController.invitesTo,
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

          if (docs.length == 0) {
            return Text("No invites yet");
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              var docData = docs[index].data();
              return InviteListItem(
                inviteFrom: docData['inviteFrom'],
                validUntil: docData['validUntil'],
                inviteID: docs[index].id,
              );
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

  Expanded _buildInvitesFromYou(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: inviteController.invitesFrom,
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
              var docData = docs[index].data();
              return InviteFromListItem(
                inviteTo: docData['inviteTo'],
                status: docData['status'],
                gameID: docs[index].id,
              );
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
}
