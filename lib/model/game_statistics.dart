class GameStatistics {
  int thrown180 = 0;
  int thrown140 = 0;
  int thrown120 = 0;
  int tonPlusCheckouts = 0;
  int checkoutsPossible = 0;
  int checkoutsHit = 0;
  List<double> averages = [];

  get checkoutPercentage => checkoutsHit / checkoutsPossible;

  bool isEmpty() {
    return averages.isEmpty;
  }

  Map<String, String> toMap() {
    return {
      '180 Thrown': thrown180.toString(),
      '140+ Thrown': thrown140.toString(),
      '120+ Thrown': thrown120.toString(),
      '100+ Checkouts': tonPlusCheckouts.toString(),
      'Checkouts Percentage': checkoutPercentage.toString(),
      'Checkouts Hit': checkoutsHit.toString(),
      'Checkout Possible': checkoutsPossible.toString(),
    };
  }

  @override
  String toString() {
    final Map<String, String> map = toMap();
    map['averages'] = averages.toString();
    return map.toString();
  }
}
