import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/pages/online_game.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
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
          _buildInvitesToYou(context),
          _buildInvitesFromYou(context),
        ],
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Invite to  ${docData['inviteTo']}"),
                  ElevatedButton(
                    onPressed: () {
                      final pageToPush = MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OnlineGame(gameID: docs[index].id);
                        },
                      );
                      Navigator.push(context, pageToPush);
                    },
                    child: Text("Start game!"),
                  ),
                ],
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
