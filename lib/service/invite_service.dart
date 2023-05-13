import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/ioc_container.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/service/toast_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InviteService {
  final _userService = get<SetupUserService>();
  final _toastService = get<ToastService>();

  Future<void> sendInvite(String receiverHash) async {
    _userService.getUserUID(receiverHash).then((receiverUID) {
      if (receiverUID.isEmpty) {
        _toastService.showErrorToast('User $receiverHash not found!');
        return;
      }

      _userService.getUserHashOfCurrentUser().then((senderHash) {
        FirebaseFirestore.instance.collection('invites').doc().set({
          'validUntil': DateTime.now().add(Duration(minutes: 30)),
          'inviteFrom': senderHash,
          'inviteFromUID': FirebaseAuth.instance.currentUser!.uid,
          'inviteToUID': receiverUID,
          'inviteTo': receiverHash,
          'status': 'pending',
        });
        _toastService.showSuccessToast('Invite sent to $receiverHash');
      });
    });
  }

  void acceptInvite(String inviteID) {
    _inviteSetStatus(inviteID, 'accepted');
  }

  void rejectInvite(String inviteID) {
    _inviteSetStatus(inviteID, 'rejected');
  }

  void deleteInvite(String inviteID) {
    FirebaseFirestore.instance.collection('invites').doc(inviteID).delete();
  }

  void _inviteSetStatus(String inviteID, String status) {
    FirebaseFirestore.instance
        .collection('invites')
        .doc(inviteID)
        .set({'status': status}, SetOptions(merge: true));
    _toastService.showSuccessToast('Invite successfully $status');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get invitesTo {
    return FirebaseFirestore.instance
        .collection('invites')
        .where('validUntil', isGreaterThanOrEqualTo: DateTime.now())
        .where('status', isEqualTo: 'pending')
        .where('inviteToUID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get invitesFrom {
    return FirebaseFirestore.instance
        .collection('invites')
        .where('validUntil', isGreaterThanOrEqualTo: DateTime.now())
        .where('inviteFromUID',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
