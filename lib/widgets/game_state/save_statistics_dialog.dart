import 'package:dartboard/model/game_notifier.dart';
import 'package:flutter/material.dart';

import '../../service/game_service.dart';
import '../../service/ioc_container.dart';

class SaveStatisticsDialog extends StatefulWidget {
  final GameNotifier currentGame;

  const SaveStatisticsDialog({Key? key, required this.currentGame})
      : super(key: key);

  @override
  State<SaveStatisticsDialog> createState() => _SaveStatisticsDialogState();
}

class _SaveStatisticsDialogState extends State<SaveStatisticsDialog> {
  int playerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Save statistics from Local Game"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("For which user have you played?"),
          DropdownButton<int>(
            value: playerIndex,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            items:
                List.generate(widget.currentGame.playerNames.length, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(widget.currentGame.playerNames[index]),
              );
            }),
            onChanged: (int? value) {
              setState(() {
                playerIndex = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            get<GameService>().saveLocalGame(playerIndex, widget.currentGame);
            Navigator.of(context).pop();
          },
          child: Text("Save statistics"),
        ),
      ],
    );
  }
}
