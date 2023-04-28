import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import 'local_game_service.dart';

/*
currently supports only local game for 2 players
 */
class GameNotifier extends ChangeNotifier {
  LocalGameService leg = LocalGameService();

  String player1Name = '';
  String player2Name = '';

  void createNewLeg({required String player1, required String player2}) {
    leg = LocalGameService();
    player1Name = player1;
    player2Name = player2;
  }

  void newGameSamePlayers() {
    String pom = player1Name;
    player1Name = player2Name;
    player2Name = pom;
    leg = LocalGameService();
    notifyListeners();
  }

  void stepBack() {
    leg.stepBack();
    notifyListeners();
  }

  void addThrow(int score, bool isDouble) {
    leg.addNewScore(score, isDouble);
    notifyListeners();
  }

  int getScore(int index) {
    return leg.getCurrentScore(index);
  }

  double getAverage(int index) {
    return leg.getCurrentAverage(index);
  }

  Visit getVisit(int index) {
    return leg.getCurrentVisit(index);
  }

  bool isMyTurn(int index) {
    return leg.isMyTurn(index);
  }

  bool getGameOver() {
    return leg.getLegEnded();
  }

  String getName(int index) {
    if (index == 0) return player1Name;
    return player2Name;
  }

  String getWinnerName() {
    if (!leg.getLegEnded()) return '';
    if (leg.getCurrentScore(0) == 0) return player1Name;
    return player2Name;
  }

  int getCurrentScore() {
    return leg.getCurrentPlayerScore();
  }
}
