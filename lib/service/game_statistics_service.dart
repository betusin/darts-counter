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
    int startingScore = 501; // TODO need to save this for a game
    int overallScore = startingScore;
    int dartsThrown = 0;

    for (Visit visit in visits) {
      //complicated stuff for checkouts possible
      for (int hit in visit.score) {
        overallScore -= hit;
        if (oneDartCheckouts.contains(overallScore)) {
          stats.checkoutsPossible += 1;
        }
      }

      if (!visit.isEmpty()) {
        dartsThrown += visit.getDarts();
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

    if (overallScore == 0) {
      stats.checkoutsHit += 1;
      if (visits.last.getTotal() >= 100) {
        stats.tonPlusCheckouts += 1;
      }
    }

    stats.averages
        .add(_getGameAverage(dartsThrown, startingScore - overallScore));

    return stats;
  }

  double _getGameAverage(int dartsThrown, int totalPointsThrown) {
    if (dartsThrown == 0) return 0.0;
    return totalPointsThrown / dartsThrown * 3;
  }
}
