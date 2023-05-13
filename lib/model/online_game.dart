import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/model/game.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

import '../service/game_service.dart';
import '../service/ioc_container.dart';

/*
only 2 players in online game supported and only mode is 501
 */
class OnlineGame extends Game {
  final _gameService = get<GameService>();
  final String gameID;
  final Function notifyCallback;
  int myIndex;
  bool waitingConfirmation = false;

  OnlineGame({super.numberOfPlayers = 2, super.startingScore = 501, required this.gameID, required this.myIndex, required this.notifyCallback}){
    //initial state
    state = GameState.initial(2);

    //start listening to the game stream
    _gameService.getGameStream(gameID).listen((event) => _handleIncomingEvent(event));
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
      state = state.copyWithNewTurn(getNextPlayer());
      state.visits[getNextPlayer()].add(const Visit(score: [], isBusted: false));
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
    myIndex = getNextPlayer();
    state = GameState.initial(2);
    _gameService.updateGameState(gameID, state);
  }

  void _handleIncomingEvent(DocumentSnapshot<GameState> event) {
    if (state.legEnded) return;
    if (!event.exists) return;
    if (event.data() != null) {
      GameState receivedState = event.data()!;
      if (receivedState.currentPlayer == myIndex || receivedState.legEnded) {
        state = receivedState;
        notifyCallback();
      }
    }
  }

  @override
  bool awaitingConfirmation() {
    return waitingConfirmation;
  }
}