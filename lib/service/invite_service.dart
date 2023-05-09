import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteService {
  final _userService = get<SetupUserService>();

  Future<void> sendInvite(String receiverHash) async {
    _userService.getUserHashOfCurrentUser().then((senderHash) {
      _userService.getUserUID(receiverHash).then((receiverUID) {
        FirebaseFirestore.instance.collection("invites").doc().set({
          "validUntil": DateTime.now().add(Duration(minutes: 30)),
          "inviteFrom": senderHash,
          "inviteFromUID": FirebaseAuth.instance.currentUser!.uid,
          "inviteToUID": receiverUID,
          "inviteTo": receiverHash,
          "status": "pending",
        });
      });
    });
  }

  void acceptInvite(String inviteID) {
    _inviteSetStatus(inviteID, "accepted");
  }

  void rejectInvite(String inviteID) {
    _inviteSetStatus(inviteID, "rejected");
  }

  void _inviteSetStatus(String inviteID, String status) {
    FirebaseFirestore.instance
        .collection("invites")
        .doc(inviteID)
        .set({"status": status}, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get invitesTo {
    return FirebaseFirestore.instance
        .collection("invites")
        .where("validUntil", isGreaterThanOrEqualTo: DateTime.now())
        .where("status", isEqualTo: "pending")
        .where("inviteToUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get invitesFrom {
    return FirebaseFirestore.instance
        .collection("invites")
        .where("validUntil", isGreaterThanOrEqualTo: DateTime.now())
        .where("inviteFromUID",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void createGame(String inviteID, String hostHash) {
    _userService.getUserUID(hostHash).then((hostUID) {
      _userService.getUserHashOfCurrentUser().then((receiverHash) {
        var data = {
          "startedAt": DateTime.now(),
          "hostHash": hostHash,
          "hostUID": hostUID,
          "receiverHash": receiverHash,
          "receiverUID": FirebaseAuth.instance.currentUser!.uid,
        };
        FirebaseFirestore.instance.collection("games").doc(inviteID).set(data);
      });
    });
  }
}
