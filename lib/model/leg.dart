import 'package:dartboard/model/game_statistics.dart';
import 'package:dartboard/model/visit.dart';

/*
class representing one LEG of darts - currently meaning one game
player1 is the one who is starting
 */
class Leg {

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
    stats = List.generate(players, (index) => GameStatistics());
  }

  void endTurn(){
    stats[currentPlayer].updateStats(currentVisit);
    lastVisit = currentVisit;
    currentVisit = Visit();
    currentPlayer = _getNextPlayer();
  }

  void addNewScore(int score, bool isDouble) {
    if (legEnded) return;
    currentVisit.addThrow(score);
    scores[currentPlayer] -= score;
    if (scores[currentPlayer] == 0 && isDouble) {       //check for game end
      legEnded = true;
      stats[currentPlayer].updateStats(currentVisit);
      return;
    }
    if (scores[currentPlayer] <= 1) {    // bust
      currentVisit.isBusted = true;
      scores[currentPlayer] += currentVisit.getTotal();
      endTurn();
      return;
    }
    if (currentVisit.isFull()) {
      endTurn();
    }
  }

  void stepBack() {
    if (legEnded) legEnded = false;
    scores[currentPlayer] += currentVisit.getLast();
    if (!currentVisit.removeThrow()) {
      if (lastVisit.isEmpty()) return;
      stats[_getPreviousPlayer()].rollBackStats(lastVisit);
      scores[_getPreviousPlayer()] += lastVisit.getLast();
      if (lastVisit.isBusted) {
        lastVisit.isBusted = false;
        scores[_getPreviousPlayer()] -= lastVisit.getTotal();
      }
      lastVisit.removeThrow();
      currentVisit = lastVisit;
      lastVisit = Visit();
      currentPlayer = _getPreviousPlayer();
    }

  }
  int getCurrentScore(int playerIndex) {
    return scores[playerIndex];
  }

  double getCurrentAverage(int playerIndex) {
    return stats[playerIndex].average;
  }

  //TODO REFACTOR TO SUPPORT MORE PLAYERS
  Visit getCurrentVisit(int index) {
    return (index == currentPlayer) ? currentVisit : lastVisit;
  }

  int _getNextPlayer() {
    return (currentPlayer + 1) % numberOfPlayers;
  }

  int _getPreviousPlayer() {
    return (currentPlayer - 1) % numberOfPlayers;
  }

  bool isMyTurn(int index) {
    return currentPlayer == index;
  }

  int getCurrentPlayerScore() {
    return scores[currentPlayer];
  }

}