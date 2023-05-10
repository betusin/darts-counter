import 'package:dartboard/model/game_service.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one local game (leg)
 */
class LocalGameService implements GameService{
  GameState state = GameState(scores: [], stats: [], visits: []);
  List<GameState> history = [];
  int numberOfPlayers = 2;

  LocalGameService({int players = 2, int startingScore = 501}){
    state = GameState(
        scores: List.filled(players, startingScore),
        stats: List.generate(players, (_) => const GameStatistics()),
        visits: List.generate(players, (_) => const Visit(score: [], isBusted: false)),
    );
    numberOfPlayers = players;
  }

  @override
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

  @override
  void stepBack() {
    if (history.isEmpty) return;
    state = history.removeLast();
  }

  @override
  int getCurrentScore(int playerIndex) {
    return state.scores[playerIndex];
  }

  @override
  double getCurrentAverage(int playerIndex) {
    return state.stats[playerIndex].getAverage();
  }

  @override
  Visit getCurrentVisit(int index) {
    return state.visits[index];
  }

  @override
  bool isMyTurn(int index) {
    return state.currentPlayer == index;
  }

  @override
  int getCurrentPlayerScore() {
    return state.scores[state.currentPlayer];
  }

  @override
  bool getLegEnded() {
    return state.legEnded;
  }

  @override
  int getWinnerIndex() {
    return state.scores.indexOf(0);
  }

  @override
  int getCurrentIndex() {
    return state.currentPlayer;
  }

  int _getNextPlayer() {
    return (state.currentPlayer + 1) % numberOfPlayers;
  }

  //ugly stuff for compatibility with online game
  @override
  bool awaitingConfirmation() {
    return false;
  }

  @override
  void confirmTurn() {
    return;
  }
}