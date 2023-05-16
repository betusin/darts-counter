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

  Future<List<GameStatistics>> getAllStatisticsForCurrentPlayer() async {
    var playerID = FirebaseAuth.instance.currentUser!.uid;

    print("Getting statistics for player $playerID");

    List<GameStatistics> allStatistics = [];

    await gameService.getAllHostGamesOfPlayer(playerID).then((playerHostGames) {
      for (var doc in playerHostGames.docs) {
        GameState state = doc.data();
        List<Visit> visits = state.visits[HOST_INDEX];

        GameStatistics gameStatistics =
            _calculateStatisticsForOneGame(visits, state.startingScore);
        allStatistics.add(gameStatistics);
      }
    });

    await gameService
        .getAllReceiverGamesOfPlayer(playerID)
        .then((playerReceiverGames) {
      for (var doc in playerReceiverGames.docs) {
        GameState state = doc.data();
        List<Visit> visits = state.visits[HOST_INDEX];

        GameStatistics gameStatistics =
            _calculateStatisticsForOneGame(visits, state.startingScore);
        allStatistics.add(gameStatistics);
      }
    });

    return allStatistics;
  }

  GameStatistics _calculateStatisticsForOneGame(
      List<Visit> visits, int overallScore) {
    GameStatistics stats = GameStatistics();

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

    return stats;
  }

  bool _isWinner(List<Visit> visits, int startingScore) {
    return startingScore - _calculateTotalPointsThrown(visits) == 0;
  }

  int _calculateTotalPointsThrown(List<Visit> visits) {
    int total = 0;
    for (var visit in visits) {
      if (!visit.isBusted) {
        total += visit.getTotal();
      }
    }
    return total;
  }
}
