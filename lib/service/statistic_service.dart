import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticService {
  Future<void> setEmptyStatisticsForUser(String id) async {
    FirebaseFirestore.instance.collection('statistics').doc(id).set({
      'checkoutsHit': 0,
      'checkoutsPossible': 0,
      'thrown120': 0,
      'thrown140': 0,
      'thrown180': 0
    });
  }
}
