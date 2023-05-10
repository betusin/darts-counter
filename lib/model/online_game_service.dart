import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String gameID;
  bool myTurn = false;
  final Function notifyCallback;
  bool waitingConfirmation = false;

  OnlineGameService({int startingScore = 501, required this.gameID, bool starting = false, required this.notifyCallback}){
    state = GameState(
      scores: List.filled(2, startingScore),
      stats: List.generate(2, (_) => const GameStatistics()),
      visits: List.generate(2, (_) => const Visit(score: [], isBusted: false)),
      currentPlayer: starting ? 0 : 1,
    );
    if (!starting) {
      _waitOpponentTurn();
    }
  }

  @override
  void addNewScore(int score, bool isDouble) {
    if (state.currentPlayer != 0) return;
    if (state.visits[0].isFull()) return;
    if (state.legEnded) return;
    Visit currentVisit = state.visits[0];
    int currentScore = state.scores[0];
    GameStatistics currentStats = state.stats[0];
    currentVisit = currentVisit.addThrow(score);
    currentScore -= score;
    if (currentScore == 0 && isDouble) {       //check for game end
      nextState(state.copyWithEnd(currentVisit, currentStats.updateStats(currentVisit)));
      return;
    }
    if (currentScore <= 1) {    // bust
      currentScore += currentVisit.getTotal();
      currentVisit = currentVisit.bust();
      nextState(state.copyWithNewScore(currentVisit, currentScore));
      waitingConfirmation = true;
      return;
    }
    if (currentVisit.isFull()) {
      nextState(state.copyWithNewScore(currentVisit, currentScore));
      waitingConfirmation = true;
      return;
    }
    nextState(state.copyWithNewScore(currentVisit, currentScore));
  }

  @override
  void confirmTurn() {
    GameStatistics currentStats = state.stats[0];
    Visit currentVisit = state.visits[0];
    nextState(state.copyWithConfirmedTurn(currentStats.updateStats(currentVisit)));
    waitingConfirmation = false;
    notifyCallback();
    _endTurn();
  }

  void _endTurn() async {
    var newScores = {
      "newScores" : state.visits[0].toString()
    };
    FirebaseFirestore.instance.collection('games').doc(gameID).update(newScores);

    _waitOpponentTurn();
  }

  void _waitOpponentTurn() async {
    print('waiting for opponent turn');
    await Future.delayed(Duration(seconds: 1));

    DocumentReference reference = FirebaseFirestore.instance.collection('games').doc(gameID);
    reference.snapshots().listen((querySnapshot) {
      if (querySnapshot.get('newScores') != ''){
        _processOpponentTurn(querySnapshot.get("newScores"));
        var empty = {'newScores' : ''};
        reference.update(empty);
      }
    });

  }

  void _processOpponentTurn(String opponentsScoreString) async {
    print('GOT SCORE: $opponentsScoreString');

    var opponentVisit = state.visits[1].fromString(opponentsScoreString);
    GameStatistics opponentStats = state.stats[1];

    if (state.scores[1] - opponentVisit.getTotal() == 0) { //opponent won
      nextState(state.copyWithEnd(opponentVisit, opponentStats.updateStats(opponentVisit)));
      history.clear();
      notifyCallback();
      return;
    }

    int opponentScore = state.scores[1] - opponentVisit.getTotal();
    nextState(state.copyWithEndTurn(opponentVisit, opponentScore, opponentStats.updateStats(opponentVisit), 0));
    history.clear();
    notifyCallback();
  }

  void nextState(GameState newState) {
    history.add(state.copyWithAll());
    state = newState;
  }

  @override
  void stepBack() {
    if (state.currentPlayer != 0) return;
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

  @override
  bool awaitingConfirmation() {
    return waitingConfirmation;
  }
}