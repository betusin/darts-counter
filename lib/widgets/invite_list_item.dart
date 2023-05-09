import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InviteListItem extends StatelessWidget {
  final inviteFrom;
  final validUntil;

  const InviteListItem({Key? key, this.inviteFrom, this.validUntil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        "$inviteFrom} is inviting you to join the game! (Valid until: ${_timestampToString(validUntil)})");
  }

  String _timestampToString(Timestamp timestamp) {
    final DateFormat formatter = DateFormat('h:mm a');
    final String formatted = formatter.format(timestamp.toDate());
    return formatted;
  }
}
