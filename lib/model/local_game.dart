import 'package:dartboard/model/game.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one local game (leg)
 */
class LocalGame extends Game {
  GameState state = GameState(visits: []);
  final int numberOfPlayers;
  final int startingScore;

  LocalGame({this.numberOfPlayers = 2, required this.startingScore}){
    state = GameState.initial(numberOfPlayers);
  }

  @override
  void addNewScore(int score, bool isDouble) {
    if (state.legEnded) return;
    int current = state.currentPlayer;
    Visit updatedVisit = state.visits[current].last.addThrow(score);
    state.visits[current].last = updatedVisit;
    //handle win
    if (startingScore - calculateTotalPointsThrown(state.visits[current]) == 0 && isDouble) {
      state = state.copyWithEnd(true);
      return;
    }
    //handle bust
    if (startingScore - calculateTotalPointsThrown(state.visits[current]) <= 1) {
      Visit bustedVisit = updatedVisit.bust();
      state.visits[current].last = bustedVisit;
      endTurn();
      return;
    }
    if (updatedVisit.isFull()) {
      endTurn();
    }
  }

  void endTurn() {
    state.visits[_getNextPlayer()].add(const Visit(score: [], isBusted: false));
    state = state.copyWithNewTurn(_getNextPlayer());
  }

  @override
  void stepBack() {
    //handle starting state - all visits are empty
    if (_allVisitsEmpty()) return;
    //handle ended leg
    if (state.legEnded) {
      state = state.copyWithEnd(false);
    }
    //handle empty visit - move back turn
    if (state.visits[state.currentPlayer].last.isEmpty()) {
      state.visits[state.currentPlayer].removeLast();
      state = state.copyWithNewTurn(_getPreviousPlayer());
    }
    //just remove one throw
    Visit updatedVisit = state.visits[state.currentPlayer].last.removeThrow();
    state.visits[state.currentPlayer].last = updatedVisit;
  }

  @override
  void reset() {
    state = GameState.initial(numberOfPlayers);
  }

  @override
  int getCurrentScore(int playerIndex) {
    return startingScore - calculateTotalPointsThrown(state.visits[playerIndex]);
  }

  @override
  double getCurrentAverage(int playerIndex) {
    int dartsThrown = calculateTotalDartsThrown(state.visits[playerIndex]);
    if (dartsThrown == 0) return 0.0;
    return calculateTotalPointsThrown(state.visits[playerIndex]) / dartsThrown * 3;
  }

  @override
  Visit getCurrentVisit(int index) {
    if (state.visits[index].isEmpty) return const Visit(score: [], isBusted: false);
    return state.visits[index].last;
  }

  @override
  bool isMyTurn(int index) {
    return state.currentPlayer == index;
  }

  @override
  int getCurrentPlayerScore() {
    return startingScore - calculateTotalPointsThrown(state.visits[state.currentPlayer]);
  }

  @override
  bool getLegEnded() {
    return state.legEnded;
  }

  @override
  int getWinnerIndex() {
    return state.visits.indexWhere((element) => startingScore - calculateTotalPointsThrown(element) == 0);
  }

  @override
  int getCurrentIndex() {
    return state.currentPlayer;
  }

  int _getNextPlayer() {
    return (state.currentPlayer + 1) % numberOfPlayers;
  }

  int _getPreviousPlayer() {
    return (state.currentPlayer - 1) % numberOfPlayers;
  }

  bool _allVisitsEmpty() {
    bool empty = true;
    for (var visits in state.visits) {
      if (visits.isNotEmpty) {
        if (visits.last.isEmpty()) continue;
        empty = false;
      }
    }
    return empty;
  }
}