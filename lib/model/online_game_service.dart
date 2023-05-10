import 'package:dartboard/model/game_service.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one online game (leg)
only 2 players in online game supported
 */
class OnlineGameService implements GameService {
  GameState state = GameState(scores: [], stats: [], visits: []);
  List<GameState> history = [];

  OnlineGameService({int startingScore = 501}){
    state = GameState(
      scores: List.filled(2, startingScore),
      stats: List.generate(2, (_) => const GameStatistics()),
      visits: List.generate(2, (_) => const Visit(score: [], isBusted: false)),
    );
  }

  @override
  void addNewScore(int score, bool isDouble) {
    //if not my turn do nothing
    //if my turn just add score locally
    //if end of turn ask for confirmation and send to firebase
  }

  //end turn function that sends stuff to firebase and maybe clears history - no more stepBacks
  //also starts some async function waiting for opponents score

  void nextState(GameState newState) {
    history.add(state.copyWithAll());
    state = newState;
  }

  @override
  void stepBack() { //do nothing if not my turn
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

  int _getNextPlayer() {
    return (state.currentPlayer + 1) % 2;
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
}