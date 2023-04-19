import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';

/*
class representing one LEG of darts - currently meaning one game
player1 is the one who is starting
 */
class Leg {

  bool player1Turn = true;
  int _player1Score = 501;
  int _player2Score = 501;

  Visit player1CurrentVisit = Visit();
  Visit player2CurrentVisit = Visit();

  final GameStatistics player1stats = GameStatistics();
  final GameStatistics player2stats = GameStatistics();
  //--------------------------------------------------------------------------------
  bool legEnded = false;
  int numberOfPlayers = 2;
  int currentPlayer = 0;  //index of player currently throwing
  List<int> scores = [];
  List<GameStatistics> stats = [];
  Visit currentVisit = Visit();
  Visit lastVisit = Visit();

  Leg({int players = 2}){
    numberOfPlayers = players;
    scores = List.filled(players, 501);
    stats = List.filled(players, GameStatistics());
  }

  void endTurn(){
    stats[currentPlayer].updateStats(currentVisit);
    lastVisit = currentVisit;
    currentVisit = Visit();

    currentPlayer = _getNextPlayer();
  }

  void addNewScore(int score, bool isDouble) {
    currentVisit.addThrow(score);
    scores[currentPlayer] -= score;
    if () {

    }

    if (player1Turn) {
      player1CurrentVisit.addThrow(score);
      _player1Score -= score;
      if (_player1Score == 0 && isDouble) {
        legEnded = true;
        player1stats.updateCheckoutsHit();
        player1stats.updateStats(player1CurrentVisit);
      }
      if (player1CurrentVisit.isFull()){
        endTurn();
      }
    }
    else {
      player2CurrentVisit.addThrow(score);
      _player2Score -= score;
      if (_player2Score == 0 && isDouble) {
        legEnded = true;
        player2stats.updateCheckoutsHit();
        player2stats.updateStats(player2CurrentVisit);
      }
      if (player2CurrentVisit.isFull()){
        endTurn();
      }
    }
  }

  //crazy function, prob has to be refactored
  void stepBack() {
    if (player1Turn) {
      _player1Score += player1CurrentVisit.getLast();
      if (!player1CurrentVisit.removeThrow()) { //trying to rollback when no darts thrown this turn -> rollback turn
        if (player2CurrentVisit.isEmpty()) return;
        player2stats.rollBackStats(player2CurrentVisit);
        _player2Score += player2CurrentVisit.getLast();
        player2CurrentVisit.removeThrow();
        player1Turn = false;
        return;
      }
    }
    else {
      _player2Score += player2CurrentVisit.getLast();
      if (!player2CurrentVisit.removeThrow()) {
        if (player1CurrentVisit.isEmpty()) return;
        player1stats.rollBackStats(player1CurrentVisit);
        _player1Score += player1CurrentVisit.getLast();
        player1CurrentVisit.removeThrow();
        player1Turn = true;
        return;
      }
    }
  }
  int getPlayer1CurrentScore() {
    return _player1Score;
  }

  int getPlayer2CurrentScore() {
    return _player2Score;
  }

  double getPlayer1CurrentAverage() {
    return player1stats.average;
  }

  double getPlayer2CurrentAverage() {
    return player2stats.average;
  }

  int _getNextPlayer() {
    return (currentPlayer + 1) % numberOfPlayers;
  }

  int _getPreviousPlayer() {
    return (currentPlayer - 1) % numberOfPlayers;
  }


}