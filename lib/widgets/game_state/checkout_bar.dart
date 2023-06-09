import 'package:dartboard/model/local_game.dart';
import 'package:dartboard/widgets/game_state/checkout_routes.dart';
import 'package:dartboard/widgets/game_state/save_statistics_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/game_notifier.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentGame = context.watch<GameNotifier>();
    final currentScore = currentGame.getCurrentScore();
    return Container(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (currentScore <= 170 &&
                currentScore > 1 &&
                !bogeyNumbers.contains(currentScore))
              ..._buildContainers(currentScore),
            if (currentGame.getGameOver())
              _buildWinnerText(context, currentGame),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContainers(int score) {
    List<Widget> containers = [];
    List<String> route = checkoutRoutes[score]!;

    for (int i = 0; i < route.length; i++) {
      containers.add(_buildCheckoutContainer(route[i]));
    }
    return containers;
  }

  Widget _buildCheckoutContainer(String checkout) {
    return Container(
      color: Colors.blue[100],
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Center(
            child: Text(
          checkout,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
        )),
      ),
    );
  }

  Widget _buildWinnerText(BuildContext context, GameNotifier currentGame) {
    List<Widget> children = [
      Text(
        '${currentGame.getWinnerName()} WON',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )
    ];

    if (currentGame.currentGame is LocalGame) {
      children.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return SaveStatisticsDialog(currentGame: currentGame);
              },
            );
          },
          child: Text("Save statistics"),
        ),
      ));
    }

    return Row(
      children: children,
    );
  }
}
