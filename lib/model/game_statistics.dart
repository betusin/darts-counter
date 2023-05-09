import 'package:dartboard/model/visit.dart';

class GameStatistics{

  final int thrown180;
  final int thrown140;
  final int thrown120;
  final int checkoutsPossible;
  final int checkoutsHit;
  final int throws;
  final int allScore;

  const GameStatistics({
    this.thrown180 = 0,
    this.thrown140 = 0,
    this.thrown120 = 0,
    this.checkoutsPossible = 0,
    this.checkoutsHit = 0,
    this.throws = 0,
    this.allScore = 0
  });

  GameStatistics updateStats(Visit visit) {
    if (visit.isBusted) { //busted visit - add nothing just recalculate average
      return GameStatistics(
          thrown120: thrown120,
          thrown140: thrown140,
          thrown180: thrown180,
          checkoutsPossible: (checkoutsPossible + 1),
          checkoutsHit: checkoutsHit,
          throws: (throws + visit.getDarts()),
          allScore: allScore
      );
    }
    int scoreThrown = visit.getTotal();
    return GameStatistics(
        thrown120: (scoreThrown >= 120) ? thrown120 : (thrown120 + 1),
        thrown140: (scoreThrown >= 140) ? thrown140 : (thrown140 + 1),
        thrown180: (scoreThrown == 180) ? thrown180 : (thrown180 + 1),
        checkoutsPossible: (checkoutsPossible + 1),
        checkoutsHit: checkoutsHit,
        throws: (throws + visit.getDarts()),
        allScore: (allScore + scoreThrown)
    );
  }

  GameStatistics updateCheckoutsPossible() {
    return GameStatistics(
      thrown120: thrown120,
      thrown140: thrown140,
      thrown180: thrown180,
      checkoutsPossible: (checkoutsPossible + 1),
      checkoutsHit: checkoutsHit,
      throws: throws,
      allScore: allScore
    );
  }

  GameStatistics updateCheckoutsHit() {
    return GameStatistics(
        thrown120: thrown120,
        thrown140: thrown140,
        thrown180: thrown180,
        checkoutsPossible: checkoutsPossible,
        checkoutsHit: (checkoutsHit + 1),
        throws: throws,
        allScore: allScore
    );
  }

  double getAverage() {
    return (throws == 0) ? 0.0 : (allScore / throws) * 3;
  }

}