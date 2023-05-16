import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

abstract class Game {
  GameState state = GameState(visits: []);
  final int numberOfPlayers;

  Game({required this.numberOfPlayers});

  void addNewScore(int score, bool isDouble);

  void stepBack();

  void reset();

  int getCurrentScore(int playerIndex) {
    return state.startingScore -
        calculateTotalPointsThrown(state.visits[playerIndex]);
  }

  double getCurrentAverage(int playerIndex) {
    int dartsThrown = calculateTotalDartsThrown(state.visits[playerIndex]);
    if (dartsThrown == 0) return 0.0;
    return calculateTotalPointsThrown(state.visits[playerIndex]) /
        dartsThrown *
        3;
  }

  Visit getCurrentVisit(int index) {
    if (state.visits[index].isEmpty) {
      return const Visit(score: [], isBusted: false);
    }
    return state.visits[index].last;
  }

  bool isMyTurn(int index) {
    return state.currentPlayer == index;
  }

  int getCurrentPlayerScore() {
    return state.startingScore -
        calculateTotalPointsThrown(state.visits[state.currentPlayer]);
  }

  bool getLegEnded() {
    return state.legEnded;
  }

  int getWinnerIndex() {
    return state.visits.indexWhere((element) =>
        state.startingScore - calculateTotalPointsThrown(element) == 0);
  }

  int getCurrentIndex() {
    return state.currentPlayer;
  }

  int getNextPlayer() {
    return (state.currentPlayer + 1) % numberOfPlayers;
  }

  int getPreviousPlayer() {
    return (state.currentPlayer - 1) % numberOfPlayers;
  }

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

  bool isBustedThrow(List<Visit> visit) {
    return state.startingScore - calculateTotalPointsThrown(visit) <= 1;
  }

  bool isWinningThrow(List<Visit> visit, bool isDouble) {
    return state.startingScore - calculateTotalPointsThrown(visit) == 0 &&
        isDouble;
  }
}
