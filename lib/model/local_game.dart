import 'package:dartboard/model/game_service.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one local game (leg)
 */
class LocalGame implements GameService{
  GameState state = GameState(visits: []);
  int numberOfPlayers = 2;
  final int startingScore;

  LocalGame({int players = 2, required this.startingScore}){
    state = GameState(
        visits: List.generate(players, (_) => []),
    );
    state.visits[0].add(const Visit(score: [], isBusted: false));
    numberOfPlayers = players;
  }

  @override
  void addNewScore(int score, bool isDouble) {
    if (state.legEnded) return;
    int current = state.currentPlayer;
    Visit updatedVisit = state.visits[current].last.addThrow(score);
    state.visits[current].last = updatedVisit;
    //handle win
    if (startingScore - _calculateTotalPointsThrown(current) == 0 && isDouble) {
      state = state.copyWithEnd(true);
      return;
    }
    //handle bust
    if (startingScore - _calculateTotalPointsThrown(current) <= 1) {
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
  int getCurrentScore(int playerIndex) {
    return startingScore - _calculateTotalPointsThrown(playerIndex);
  }

  @override
  double getCurrentAverage(int playerIndex) {
    int dartsThrown = _calculateTotalDartsThrown(playerIndex);
    if (dartsThrown == 0) return 0.0;
    return _calculateTotalPointsThrown(playerIndex) / dartsThrown * 3;
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
    return startingScore - _calculateTotalPointsThrown(state.currentPlayer);
  }

  @override
  bool getLegEnded() {
    return state.legEnded;
  }

  @override
  int getWinnerIndex() {
    return state.visits.indexWhere((element) => startingScore - _calculateTotalPointsThrown(state.visits.indexOf(element)) == 0);
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

  int _calculateTotalPointsThrown(int index) {
    int total = 0;
      for (var visit in state.visits[index]) {
        if (!visit.isBusted) {
          total += visit.getTotal();
        }
      }
    return total;
  }

  int _calculateTotalDartsThrown(int index) {
    int total = 0;
    for (var visit in state.visits[index]) {
      if (!visit.isEmpty()) {
        total += visit.getDarts();
      }
    }
    return total;
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
  
  @override
  bool awaitingConfirmation() {
    return false;
  }

  @override
  void confirmTurn() {
    return;
  }
}