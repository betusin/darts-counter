import 'package:dartboard/model/game_state.dart';
import 'package:dartboard/model/visit.dart';
import 'package:dartboard/service/game_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/game_statistics.dart';
import '../widgets/game_state/checkout_routes.dart';
import 'ioc_container.dart';

const HOST_INDEX = 0; // host always start the game
const RECEIVER_INDEX = 1;

class GameStatisticsService {
  final GameService gameService = get<GameService>();

  Future<GameStatistics> getAllStatisticsForCurrentPlayer() async {
    var playerID = FirebaseAuth.instance.currentUser!.uid;

    print("Getting statistics for player $playerID");

    GameStatistics gameStatistics = GameStatistics();

    await gameService.getAllHostGamesOfPlayer(playerID).then((playerHostGames) {
      for (var doc in playerHostGames.docs) {
        GameState state = doc.data();
        List<Visit> visits = state.visits[HOST_INDEX];

        gameStatistics = _calculateStatisticsForOneGame(visits, gameStatistics);
      }
    });

    await gameService
        .getAllReceiverGamesOfPlayer(playerID)
        .then((playerReceiverGames) {
      for (var doc in playerReceiverGames.docs) {
        GameState state = doc.data();
        List<Visit> visits = state.visits[HOST_INDEX];

        gameStatistics = _calculateStatisticsForOneGame(visits, gameStatistics);
      }
    });

    print("resulting game stats: $gameStatistics");

    return gameStatistics;
  }

  GameStatistics _calculateStatisticsForOneGame(
      List<Visit> visits, GameStatistics stats) {
    int overallScore = 501; // TODO need to save this for a game

    for (Visit visit in visits) {
      //complicated stuff for checkouts possible
      for (int hit in visit.score) {
        overallScore -= hit;
        if (oneDartCheckouts.contains(overallScore)) {
          stats.checkoutsPossible += 1;
        }
      }
      if (visit.isBusted) {
        overallScore += visit.getTotal();
        continue;
      }

      int score = visit.getTotal();
      if (score == 180) stats.thrown180 += 1;
      if (score >= 140) stats.thrown140 += 1;
      if (score >= 120) stats.thrown120 += 1;
    }

    if (_isWinner(visits, overallScore)) {
      stats.checkoutsHit += 1;
      if (visits.last.getTotal() >= 100) {
        stats.tonPlusCheckouts += 1;
      }
    }

    stats.averages.add(_getGameAverage(visits));

    print(stats);
    return stats;
  }

  bool _isWinner(List<Visit> visits, int startingScore) {
    return startingScore - _calculateTotalPointsThrown(visits) == 0;
  }

  // TODO these three methods are in game, probably move to service and reuse here?

  int _calculateTotalPointsThrown(List<Visit> visits) {
    int total = 0;
    for (var visit in visits) {
      if (!visit.isBusted) {
        total += visit.getTotal();
      }
    }
    return total;
  }

  int _calculateTotalDartsThrown(List<Visit> visits) {
    int total = 0;
    for (var visit in visits) {
      if (!visit.isEmpty()) {
        total += visit.getDarts();
      }
    }
    return total;
  }

  double _getGameAverage(List<Visit> visits) {
    int dartsThrown = _calculateTotalDartsThrown(visits);
    if (dartsThrown == 0) return 0.0;
    return _calculateTotalPointsThrown(visits) / dartsThrown * 3;
  }
}
