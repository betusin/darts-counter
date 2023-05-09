import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import 'game_service.dart';
import 'local_game_service.dart';

/*
TODO finish support for online game
 */
class GameNotifier extends ChangeNotifier {
  GameService currentGame = LocalGameService();

  int numberOfPlayers = 2;
  List<String> playerNames = [];
  int startingScore = 501;
  List<int> victories = [];

  void createNewLocalGame({required int number, required List<String> names, int starting = 501}) {
    currentGame = LocalGameService(players: number, startingScore: starting);
    numberOfPlayers = number;
    playerNames = names;
    startingScore = starting;
    victories = List.filled(number, 0, growable: true);
  }

  void newGameSamePlayers() {
    victories[currentGame.getWinnerIndex()] += 1;
    String pom = playerNames.removeLast();
    playerNames.insert(0, pom);
    victories.insert(0, victories.removeLast());
    currentGame = LocalGameService(players: numberOfPlayers, startingScore: startingScore);
    notifyListeners();
  }

  void stepBack() {
    currentGame.stepBack();
    notifyListeners();
  }

  void addThrow(int score, bool isDouble) {
    currentGame.addNewScore(score, isDouble);
    notifyListeners();
  }

  int getScore(int index) {
    return currentGame.getCurrentScore(index);
  }

  double getAverage(int index) {
    return currentGame.getCurrentAverage(index);
  }

  Visit getVisit(int index) {
    return currentGame.getCurrentVisit(index);
  }

  bool isMyTurn(int index) {
    return currentGame.isMyTurn(index);
  }

  bool getGameOver() {
    return currentGame.getLegEnded();
  }

  String getName(int index) {
    return playerNames[index];
  }

  String getWinnerName() {
    if (!currentGame.getLegEnded()) return '';
    return playerNames[currentGame.getWinnerIndex()];
  }

  int getCurrentScore() {
    return currentGame.getCurrentPlayerScore();
  }

  int getNumberOfPlayers() {
    return numberOfPlayers;
  }

  int getCurrentPlayerIndex() {
    return currentGame.getCurrentIndex();
  }

  int getVictories(int index) {
    return victories[index];
  }
}
