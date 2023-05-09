import 'package:cloud_firestore/cloud_firestore.dart';

class SetupUserService {
  Future<void> createCollectionsForUser(String id) async {
    createStatisticsForUser(id);
    createInvitesForUser(id);
  }

  Future<void> createStatisticsForUser(String id) async {
    FirebaseFirestore.instance.collection("statistics").doc(id).set({
      "checkoutsHit": 0,
      "checkoutsPossible": 0,
      "thrown120": 0,
      "thrown140": 0,
      "thrown180": 0
    });
  }

  Future<void> createInvitesForUser(String id) async {
    FirebaseFirestore.instance.collection("users").doc(id).set({
      "inviteHash": _generateUserHash(id),
    });
  }

  Future<String> getUserHash(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((doc) => doc.get("inviteHash"));
  }

  String _generateUserHash(String uid) {
    DateTime now = DateTime.now();
    int microseconds = now.microsecondsSinceEpoch;
    String id = uid.substring(0, 3) + microseconds.toString().substring(0, 3);
    return id;
  }
}
