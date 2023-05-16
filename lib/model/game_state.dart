import 'package:dartboard/model/visit.dart';

class GameState {
  final bool legEnded;
  final int currentPlayer;
  final int startingScore;
  final List<List<Visit>> visits;

  const GameState({
    this.legEnded = false,
    this.currentPlayer = 0,
    this.startingScore = 501,
    required this.visits,
  });

  GameState.initial(int numberOfPlayers, this.startingScore)
      : legEnded = false,
        currentPlayer = 0,
        visits = List.generate(
          numberOfPlayers,
          (index) => (index == 0) ? [Visit(score: [], isBusted: false)] : [],
        );

  GameState copyWithNewTurn(int nextPlayer) {
    return GameState(
      visits: visits,
      currentPlayer: nextPlayer,
      startingScore: startingScore,
    );
  }

  GameState copyWithEnd(bool ended) {
    return GameState(
      visits: visits,
      legEnded: ended,
      currentPlayer: currentPlayer,
      startingScore: startingScore,
    );
  }
}
