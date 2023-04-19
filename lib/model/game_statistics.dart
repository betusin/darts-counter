import 'package:dartboard/model/visit.dart';

class GameStatistics{

  int thrown180 = 0;
  int thrown140 = 0;
  int thrown120 = 0;
  double average = 0.0;
  int checkoutsPossible = 0;
  int checkoutsHit = 0;

  int throws = 0;
  int allScore = 0;

  void updateStats(Visit visit) {
    if (visit.isBusted) { //busted visit - add nothing just recalculate average
      throws += visit.getDarts();
      average = (allScore / throws) * 3;
      return;
    }
    final scoreThrown = visit.getTotal();
    throws += visit.getDarts();
    allScore += scoreThrown;

    if (scoreThrown >= 120) thrown120++;
    if (scoreThrown >= 140) thrown140++;
    if (scoreThrown == 180) thrown180++;

    if (throws == 0) {
      average = 0.0;
    }
    else {
      average = (allScore / throws) * 3;
    }
  }

  void rollBackStats(Visit visit){
    if (visit.isBusted) { //busted visit - add nothing just recalculate average
      throws -= visit.getDarts();
      average = (allScore / throws) * 3;
      return;
    }
    final scoreThrown = visit.getTotal();
    throws -= visit.getDarts();
    allScore -= scoreThrown;

    if (scoreThrown >= 120) thrown120--;
    if (scoreThrown >= 140) thrown140--;
    if (scoreThrown == 180) thrown180--;

    if (throws == 0) {
      average = 0.0;
    }
    else {
      average = (allScore / throws) * 3;
    }
  }

  void updateCheckoutsPossible() {
    checkoutsPossible++;
  }

  void updateCheckoutsHit() {
    checkoutsHit ++;
  }
}