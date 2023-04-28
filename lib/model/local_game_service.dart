import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one local game (leg)
 */
class LocalGameService {
  GameState state = GameState(scores: [], stats: [], visits: []);
  List<GameState> history = [];

  LocalGameService({int players = 2}){
    state = GameState(
        scores: List.filled(players, 501),
        stats: List.generate(players, (_) => const GameStatistics()),
        visits: List.generate(players, (_) => const Visit(score: [], isBusted: false)),
    );
  }

  void addNewScore(int score, bool isDouble) {
    if (state.legEnded) return;
    Visit currentVisit = state.visits[state.currentPlayer];
    int currentScore = state.scores[state.currentPlayer];
    GameStatistics currentStats = state.stats[state.currentPlayer];
    currentVisit = currentVisit.addThrow(score);
    currentScore -= score;
    if (currentScore == 0 && isDouble) {       //check for game end
      nextState(state.copyWithEnd(currentVisit, currentStats.updateStats(currentVisit)));
      return;
    }
    if (currentScore <= 1) {    // bust
      currentScore += currentVisit.getTotal();
      currentVisit = currentVisit.bust();
      nextState(state.copyWithEndTurn(currentVisit, currentScore, currentStats.updateStats(currentVisit), _getNextPlayer()));
      return;
    }
    if (currentVisit.isFull()) {
      nextState(state.copyWithEndTurn(currentVisit, currentScore, currentStats.updateStats(currentVisit), _getNextPlayer()));
      return;
    }
    nextState(state.copyWithNewScore(currentVisit, currentScore));
  }

  void nextState(GameState newState) {
    history.add(state.copyWithAll());
    state = newState;
  }

  void stepBack() {
    if (history.isEmpty) return;
    state = history.removeLast();
  }

  int getCurrentScore(int playerIndex) {
    return state.scores[playerIndex];
  }

  double getCurrentAverage(int playerIndex) {
    return state.stats[playerIndex].getAverage();
  }

  Visit getCurrentVisit(int index) {
    return state.visits[index];
  }

  int _getNextPlayer() {
    return (state.currentPlayer + 1) % state.numberOfPlayers;
  }

  bool isMyTurn(int index) {
    return state.currentPlayer == index;
  }

  int getCurrentPlayerScore() {
    return state.scores[state.currentPlayer];
  }

  bool getLegEnded() {
    return state.legEnded;
  }
}