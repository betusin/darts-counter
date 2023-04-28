import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import 'local_game_service.dart';

/*
currently supports only local game for 2 players
TODO finish support for more players
TODO finish support for online game
 */
class GameNotifier extends ChangeNotifier {
  LocalGameService localGame = LocalGameService();

  int numberOfPlayers = 2;
  List<String> playerNames = [];
  int startingScore = 501;

  void createNewLocalGame({required int number, required List<String> names, int starting = 501}) {
    localGame = LocalGameService(players: number, startingScore: starting);
    numberOfPlayers = number;
    playerNames = names;
    startingScore = starting;
  }

  void newGameSamePlayers() {
    String pom = playerNames[0];
    playerNames[0] = playerNames[1];
    playerNames[1] = pom;
    localGame = LocalGameService();
    notifyListeners();
  }

  void stepBack() {
    localGame.stepBack();
    notifyListeners();
  }

  void addThrow(int score, bool isDouble) {
    localGame.addNewScore(score, isDouble);
    notifyListeners();
  }

  int getScore(int index) {
    return localGame.getCurrentScore(index);
  }

  double getAverage(int index) {
    return localGame.getCurrentAverage(index);
  }

  Visit getVisit(int index) {
    return localGame.getCurrentVisit(index);
  }

  bool isMyTurn(int index) {
    return localGame.isMyTurn(index);
  }

  bool getGameOver() {
    return localGame.getLegEnded();
  }

  String getName(int index) {
    return playerNames[index];
  }

  String getWinnerName() {
    if (!localGame.getLegEnded()) return '';
    if (localGame.getCurrentScore(0) == 0) return playerNames[0];
    return playerNames[1];
  }

  int getCurrentScore() {
    return localGame.getCurrentPlayerScore();
  }
}
