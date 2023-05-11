import 'package:dartboard/model/visit.dart';

class GameState {
  final bool legEnded;
  final int currentPlayer;
  final List<List<Visit>> visits;

  const GameState({
    this.legEnded = false,
    this.currentPlayer = 0,
    required this.visits,
  });

  GameState copyWithNewTurn(int nextPlayer) {
    return GameState(visits: visits, currentPlayer: nextPlayer);
  }

  GameState copyWithEnd(bool ended) {
    return GameState(visits: visits, legEnded: ended, currentPlayer: currentPlayer);
  }
}