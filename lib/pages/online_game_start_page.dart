import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:flutter/material.dart';

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
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, "/game/online"),
            child: Text("Start game!"),
          )
        ],
      ),
    );
  }
}
