import 'package:dartboard/model/game.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one local game (leg)
 */
class LocalGame extends Game {

  LocalGame({super.numberOfPlayers = 2, required super.startingScore}){
    state = GameState.initial(numberOfPlayers);
  }

  @override
  void addNewScore(int score, bool isDouble) {
    if (state.legEnded) return;

    int current = state.currentPlayer;
    Visit updatedVisit = state.visits[current].last.addThrow(score);
    state.visits[current].last = updatedVisit;
    if (startingScore - calculateTotalPointsThrown(state.visits[current]) == 0 && isDouble) { //win
      state = state.copyWithEnd(true);
      return;
    }
    if (startingScore - calculateTotalPointsThrown(state.visits[current]) <= 1) { //bust
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
    state.visits[getNextPlayer()].add(const Visit(score: [], isBusted: false));
    state = state.copyWithNewTurn(getNextPlayer());
  }

  @override
  void stepBack() {
    //starting state - all visits are empty
    if (_allVisitsEmpty()) return;
    //handle ended leg
    if (state.legEnded) {
      state = state.copyWithEnd(false);
    }
    //handle empty visit - move back turn
    if (state.visits[state.currentPlayer].last.isEmpty()) {
      state.visits[state.currentPlayer].removeLast();
      state = state.copyWithNewTurn(getPreviousPlayer());
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
  int getCurrentIndex() {
    return state.currentPlayer;
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