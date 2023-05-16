class GameStatistics {
  int thrown180 = 0;
  int thrown140 = 0;
  int thrown120 = 0;
  int tonPlusCheckouts = 0;
  int checkoutsPossible = 0;
  int checkoutsHit = 0;
  List<double> averages = [];

  Map<String, String> toMap() {
    return {
      '180s Thrown': thrown180.toString(),
      '140s Thrown': thrown140.toString(),
      '120s Thrown': thrown120.toString(),
      'tonPlusCheckouts': tonPlusCheckouts.toString(),
      'checkoutsPossible': checkoutsPossible.toString(),
      'checkoutsHit': checkoutsHit.toString(),
    };
  }

  @override
  String toString() {
    final Map<String, String> map = toMap();
    map['averages'] = averages.toString();
    return map.toString();
  }
}
