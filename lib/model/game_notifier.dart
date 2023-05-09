import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import 'local_game_service.dart';

/*
currently supports only local game
TODO finish support for online game
 */
class GameNotifier extends ChangeNotifier {
  LocalGameService localGame = LocalGameService();

  int numberOfPlayers = 2;
  List<String> playerNames = [];
  int startingScore = 501;
  List<int> victories = [];

  void createNewLocalGame({required int number, required List<String> names, int starting = 501}) {
    localGame = LocalGameService(players: number, startingScore: starting);
    numberOfPlayers = number;
    playerNames = names;
    startingScore = starting;
    victories = List.filled(number, 0, growable: true);
  }

  void newGameSamePlayers() {
    victories[localGame.getWinnerIndex()] += 1;
    String pom = playerNames.removeLast();
    playerNames.insert(0, pom);
    victories.insert(0, victories.removeLast());
    localGame = LocalGameService(players: numberOfPlayers, startingScore: startingScore);
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
    return playerNames[localGame.getWinnerIndex()];
  }

  int getCurrentScore() {
    return localGame.getCurrentPlayerScore();
  }

  int getNumberOfPlayers() {
    return numberOfPlayers;
  }

  int getCurrentPlayerIndex() {
    return localGame.getCurrentIndex();
  }

  int getVictories(int index) {
    return victories[index];
  }
}
