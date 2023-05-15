import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';
import 'package:dartboard/widgets/game_state/checkout_routes.dart';

abstract class Game {
  GameState state = GameState(visits: []);
  final int numberOfPlayers;
  final int startingScore;

  Game({required this.numberOfPlayers, required this.startingScore});

  void addNewScore(int score, bool isDouble);

  void stepBack();

  void reset();

  int getCurrentScore(int playerIndex) {
    return startingScore -
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
    return startingScore -
        calculateTotalPointsThrown(state.visits[state.currentPlayer]);
  }

  bool getLegEnded() {
    return state.legEnded;
  }

  int getWinnerIndex() {
    return state.visits.indexWhere(
        (element) => startingScore - calculateTotalPointsThrown(element) == 0);
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

  GameStatistics calculatePlayersStatistics(int index) {
    GameStatistics stats = GameStatistics();
    int overallScore = startingScore;
    for (Visit visit in state.visits[index]) {
      //complicated stuff for checkouts possible
      for (int hit in visit.score) {
        overallScore -= hit;
        if (oneDartCheckouts.contains(overallScore))
          stats.checkoutsPossible += 1;
      }
      if (visit.isBusted) {
        overallScore += visit.getTotal();
        continue;
      }
      int score = visit.getTotal();
      if (score == 180) stats.thrown180 += 1;
      if (score >= 140) stats.thrown140 += 1;
      if (score >= 120) stats.thrown120 += 1;
    }
    if (getWinnerIndex() == index) {
      stats.checkoutsHit += 1;
      if (state.visits[index].last.getTotal() >= 100)
        stats.tonPlusCheckouts += 1;
    }
    return stats;
  }
}
