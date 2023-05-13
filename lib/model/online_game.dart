import 'package:dartboard/model/game.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

import '../service/game_service.dart';
import '../service/ioc_container.dart';

/*
service controlling one online game (leg)
only 2 players in online game supported
 */
class OnlineGame extends Game {
  final _gameService = get<GameService>();
  GameState state = GameState(visits: []);
  final String gameID;
  int myIndex;
  final int startingScore;
  final Function notifyCallback;
  bool waitingConfirmation = false;

  OnlineGame({this.startingScore = 501, required this.gameID, required this.myIndex, required this.notifyCallback}){
    //initial state
    state = GameState.initial(2);

    //start listening to the game stream
    _gameService.getGameStream(gameID).listen(
            (event) {
              if (state.legEnded) return;
              if (!event.exists) return;
              if (event.data() != null) {
                GameState receivedState = event.data()!;
                if (receivedState.currentPlayer == myIndex || receivedState.legEnded) {
                  state = receivedState;
                  notifyCallback();
                }
              }
            });
  }

  @override
  void addNewScore(int score, bool isDouble) {
    if (state.currentPlayer != myIndex) return;
    if (state.legEnded) return;
    if (state.visits[myIndex].last.isFull() || state.visits[myIndex].last.isBusted) return;

    Visit updatedVisit = state.visits[myIndex].last.addThrow(score);
    state.visits[myIndex].last = updatedVisit;
    //handle win
    if (startingScore - calculateTotalPointsThrown(state.visits[myIndex]) == 0 && isDouble) {
      state = state.copyWithEnd(true);
      waitingConfirmation = true;
      return;
    }
    //handle bust
    if (startingScore - calculateTotalPointsThrown(state.visits[myIndex]) <= 1) {
      state.visits[myIndex].last = updatedVisit.bust();
      waitingConfirmation = true;
      return;
    }
    if (updatedVisit.isFull()) {
      waitingConfirmation = true;
    }
  }

  @override
  void confirmTurn() {
    if (!state.legEnded) {
      state = state.copyWithNewTurn(_getOtherPlayerIndex());
      state.visits[_getOtherPlayerIndex()].add(const Visit(score: [], isBusted: false));
    }
    _gameService.updateGameState(gameID, state);
    waitingConfirmation = false;
  }

  @override
  void stepBack() {
    if (state.currentPlayer != myIndex) return; //do nothing if not my turn
    if (state.visits[myIndex].last.isEmpty()) return; //do nothing if my turn is empty
    if (state.legEnded && !waitingConfirmation) return; //i won and i confirmed it so do nothing
    if (waitingConfirmation) waitingConfirmation = false; //revert confirmation
    if (state.legEnded) state = state.copyWithEnd(false); //revert win
    state.visits[myIndex].last = state.visits[myIndex].last.removeThrow(); //just remove one throw from my visit
  }

  @override
  void reset() {
    myIndex = _getOtherPlayerIndex();
    state = GameState.initial(2);
    _gameService.updateGameState(gameID, state);
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

  @override
  bool awaitingConfirmation() {
    return waitingConfirmation;
  }

  int _getOtherPlayerIndex() {
    return (myIndex + 1) % 2;
  }
}