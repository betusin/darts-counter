import 'package:dartboard/model/visit.dart';

import 'game_statistics.dart';

class GameState {
  final bool legEnded;
  final int currentPlayer;
  final List<int> scores;
  final List<GameStatistics> stats;
  final List<Visit> visits;

  const GameState({
    this.legEnded = false,
    this.currentPlayer = 0,
    required this.scores,
    required this.stats,
    required this.visits,
  });

  GameState copyWithAll() {
    return GameState(legEnded: legEnded, currentPlayer: currentPlayer, scores: List.from(scores), stats: List.from(stats), visits: List.from(visits));
  }

  GameState copyWithEnd(Visit finalVisit, GameStatistics finalStats) {
    List<int> newScores = List.from(scores);
    List<Visit> newVisits = List.from(visits);
    List<GameStatistics> newStats = List.from(stats);
    newScores[currentPlayer] = 0;
    newStats[currentPlayer] = finalStats;
    newVisits[currentPlayer] = finalVisit;
    return GameState(legEnded: true, currentPlayer: currentPlayer, scores: newScores, stats: newStats, visits: newVisits);
  }

  GameState copyWithNewScore(Visit visit, int score) {
    List<int> newScores = List.from(scores);
    List<Visit> newVisits = List.from(visits);
    newVisits[currentPlayer] = visit;
    newScores[currentPlayer] = score;
    return GameState(legEnded: legEnded, currentPlayer: currentPlayer, scores: newScores, stats: List.from(stats), visits: newVisits);
  }

  GameState copyWithEndTurn(Visit visit, int score, GameStatistics newStat, int nextPlayer) {
    List<int> newScores = List.from(scores);
    List<Visit> newVisits = List.from(visits);
    List<GameStatistics> newStats = List.from(stats);
    newVisits[currentPlayer] = visit;
    newScores[currentPlayer] = score;
    newStats[currentPlayer] = newStat;
    newVisits[nextPlayer] = const Visit(score: [], isBusted: false);
    return GameState(legEnded: legEnded, currentPlayer: nextPlayer, scores: newScores, stats: newStats, visits: newVisits);
  }
}