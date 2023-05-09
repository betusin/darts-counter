import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/invite_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../service/ioc_container.dart';

class InviteListItem extends StatelessWidget {
  final String inviteFrom;
  final Timestamp validUntil;
  final String inviteID;

  const InviteListItem(
      {Key? key,
      required this.inviteFrom,
      required this.validUntil,
      required this.inviteID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inviteController = get<InviteService>();

    return Center(
      child: Column(
        children: [
          Text(
              "$inviteFrom} is inviting you to join the game! (Valid until: ${_timestampToString(validUntil)})"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  inviteController.acceptInvite(inviteID);
                  inviteController.createGame(inviteID, inviteFrom);
                  Navigator.pushNamed(context, "/game/online");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Accept"),
              ),
              ElevatedButton(
                onPressed: () {
                  inviteController.acceptInvite(inviteID);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: Text("Reject"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _timestampToString(Timestamp timestamp) {
    final DateFormat formatter = DateFormat('h:mm a');
    final String formatted = formatter.format(timestamp.toDate());
    return formatted;
  }
}
