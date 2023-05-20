import 'package:dartboard/model/game_state.dart';

class FirebaseGame {
  final GameState gameState;
  final List<String> playerUIDs;

  FirebaseGame({
    required this.gameState,
    required this.playerUIDs,
  });

  @override
  String toString() {
    return 'FirebaseGame{gameState: $gameState, playerUIDs: $playerUIDs}';
  }
}
