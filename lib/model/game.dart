import 'package:dartboard/model/visit.dart';

abstract class Game {

  void addNewScore(int score, bool isDouble);

  void stepBack();

  int getCurrentScore(int playerIndex);

  double getCurrentAverage(int playerIndex);

  Visit getCurrentVisit(int index);

  bool isMyTurn(int index);

  int getCurrentPlayerScore();

  bool getLegEnded();

  int getWinnerIndex();

  int getCurrentIndex();

  void reset();

  int calculateTotalDartsThrown(List<Visit> visits) {
    int total = 0;
    for (var visit in visits) {
      if (!visit.isEmpty()) {
        total += visit.getDarts();
      }
    }
    return total;
  }

  int calculateTotalPointsThrown(List<Visit> visits) {
    int total = 0;
    for (var visit in visits) {
      if (!visit.isBusted) {
        total += visit.getTotal();
      }
    }
    return total;
  }

  bool awaitingConfirmation() {
    return false;
  }

  void confirmTurn() {
    return;
  }
}
