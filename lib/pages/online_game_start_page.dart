import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:flutter/material.dart';

import '../widgets/invite_list_item.dart';

class OnlineGameStartPage extends StatelessWidget {
  const OnlineGameStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    var inviteController = get<InviteService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Invite your friends"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
            onPressed: () {
              print("will send invite to ${textController.value.text}");

              inviteController.sendInvite(textController.value.text);
              textController.clear();
            },
            child: Text("Invite friend"),
          ),
          _buildInvites(context),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/game/online"),
            child: Text("Start game!"),
          )
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
}
