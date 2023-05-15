import 'package:flutter/material.dart';

import '../../pages/online_game_page.dart';

class InviteFromListItem extends StatelessWidget {
  final String status;
  final String gameID;
  final String inviteTo;

  const InviteFromListItem(
      {Key? key,
      required this.status,
      required this.gameID,
      required this.inviteTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Invite to  $inviteTo'),
        Text(status),
        if (status == 'accepted')
          ElevatedButton(
            onPressed: () {
              final pageToPush = MaterialPageRoute(
                builder: (BuildContext context) {
                  return OnlineGamePage(gameID: gameID, myIndex: 0);
                },
              );
              Navigator.push(context, pageToPush);
            },
            child: Text('Join game!'),
          ),
      ],
    );
  }
}
