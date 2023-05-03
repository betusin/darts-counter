import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteService {
  final currentUserHash = get<SetupUserService>()
      .getUserHash(FirebaseAuth.instance.currentUser!.uid);

  Future<void> sendInvite(String inviteHash) async {
    FirebaseFirestore.instance.collection("invites").doc(inviteHash).set({
      "validUntil": DateTime.now().add(Duration(minutes: 30)),
      "inviteFrom": currentUserHash,
    }, SetOptions(merge: true));
  }
}
