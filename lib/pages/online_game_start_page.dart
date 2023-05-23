import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/widgets/handlers/handling_stream_builder.dart';
import 'package:dartboard/widgets/invites/invite_from_list_item.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/invites/invite_list_item.dart';

class OnlineGameStartPage extends StatelessWidget {
  var inviteController = get<InviteService>();

  OnlineGameStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Invite your friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  inviteController.sendInvite(textController.value.text);
                  textController.clear();
                },
                child: Text('Invite the friend'),
              ),
            ),
            Divider(),
            Text(
              'Invites to You',
              style: TextStyle(fontSize: 20),
            ),
            _buildInvitesToYou(context),
            Divider(),
            Text(
              'Invites from You',
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
      child: HandlingStreamBuilder<QuerySnapshot>(
        stream: inviteController.invitesTo,
        builder: (BuildContext context, dynamic data) {
          final docs = data.docs;

          if (docs.length == 0) {
            return Text('No invites yet');
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
      child: HandlingStreamBuilder<QuerySnapshot>(
        stream: inviteController.invitesFrom,
        builder: (BuildContext context, dynamic data) {
          final docs = data.docs;

          if (docs.length == 0) {
            return Text('No invites yet');
          }

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
