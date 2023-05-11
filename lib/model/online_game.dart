import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/model/game_service.dart';
import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';

/*
service controlling one online game (leg)
only 2 players in online game supported
 */
class OnlineGame implements GameService {
  GameState state = GameState(visits: []);
  final String gameID;
  bool myTurn = false;
  final Function notifyCallback;
  bool waitingConfirmation = false;

  OnlineGame({int startingScore = 501, required this.gameID, bool starting = false, required this.notifyCallback}){
    state = GameState(
      visits: List.generate(2, (_) => [const Visit(score: [], isBusted: false)]),
      currentPlayer: starting ? 0 : 1,
    );
    if (!starting) {
      _waitOpponentTurn();
    }
  }

  //TODO
  @override
  void addNewScore(int score, bool isDouble) {
    if (state.currentPlayer != 0) return;

  }

  @override
  void confirmTurn() {

  }

  void _endTurn() async {

  }

  void _waitOpponentTurn() async {

  }

  void _processOpponentTurn(String opponentsScoreString) async {

  }

  //TODO
  @override
  void stepBack() {
    if (state.currentPlayer != 0) return;

  }

  //TODO
  @override
  int getCurrentScore(int playerIndex) {
    return 999;
  }

  //TODO
  @override
  double getCurrentAverage(int playerIndex) {
    return 6.9;
  }

  @override
  Visit getCurrentVisit(int index) {
    return state.visits[index].last;
  }

  @override
  bool isMyTurn(int index) {
    return state.currentPlayer == index;
  }

  //TODO
  @override
  int getCurrentPlayerScore() {
    return 999;
  }

  @override
  bool getLegEnded() {
    return state.legEnded;
  }

  //TODO
  @override
  int getWinnerIndex() {
    return 0;
  }

  @override
  int getCurrentIndex() {
    return state.currentPlayer;
  }

  @override
  bool awaitingConfirmation() {
    return waitingConfirmation;
  }
}