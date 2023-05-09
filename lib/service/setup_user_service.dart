import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String> getUserHashOfCurrentUser() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) => doc.get("inviteHash"));
  }

  Future<String> getUserUID(String userHash) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("inviteHash", isEqualTo: userHash)
        .get()
        .then((querySnapshot) {
      var id = "";
      for (var docSnapshot in querySnapshot.docs) {
        id = docSnapshot.id;
      }
      // TODO handle if inviteHash not found
      return id;
    });
  }

  String _generateUserHash(String uid) {
    DateTime now = DateTime.now();
    String microseconds = now.microsecondsSinceEpoch.toString();
    print(microseconds);
    String id =
        uid.substring(0, 3) + microseconds.substring(microseconds.length - 3);
    print(id);
    return id;
  }
}
