import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteService {
  final _userService = get<SetupUserService>();

  Future<void> sendInvite(String receiverHash) async {
    String senderUID = FirebaseAuth.instance.currentUser!.uid;

    _userService.getUserHash(senderUID).then((senderHash) {
      _userService.getUserUID(receiverHash).then((receiverUID) {
        FirebaseFirestore.instance.collection(receiverUID).doc().set({
          "validUntil": DateTime.now().add(Duration(minutes: 30)),
          "inviteFrom": senderHash,
        });
      });
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get invites {
    return FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
