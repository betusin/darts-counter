import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteService {
  final _userService = get<SetupUserService>();

  Future<void> sendInvite(String inviteHash) async {
    FirebaseFirestore.instance.collection("invites").doc(inviteHash).set({
      "validUntil": DateTime.now().add(Duration(minutes: 30)),
      "inviteFrom":
          _userService.getUserHash(FirebaseAuth.instance.currentUser!.uid),
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get invites {
    final userHash = "rD8168";
    return FirebaseFirestore.instance
        .collection("invites")
        .doc(userHash)
        .snapshots();
  }
}
