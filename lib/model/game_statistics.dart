class GameStatistics {
  int thrown180 = 0;
  int thrown140 = 0;
  int thrown120 = 0;
  int tonPlusCheckouts = 0;
  int checkoutsPossible = 0;
  int checkoutsHit = 0;

  @override
  String toString() {
    return "{thrown180: $thrown180,"
        "thrown140: $thrown140,"
        "thrown120: $thrown120,"
        "tonPlusCheckouts: $tonPlusCheckouts,"
        "checkoutsPossible: $checkoutsPossible,"
        "checkoutsHit: $checkoutsHit}";
  }
}
