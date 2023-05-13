import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/game_state.dart';
import '../model/visit.dart';
import 'ioc_container.dart';

class GameService {
  final _userService = get<SetupUserService>();

  void createGame(String inviteID, String hostHash) {
    _userService.getUserUID(hostHash).then((hostUID) {
      _userService.getUserHashOfCurrentUser().then((receiverHash) {
        var data = {
          'startedAt': DateTime.now(),
          'hostHash': hostHash,
          'hostUID': hostUID,
          'receiverHash': receiverHash,
          'receiverUID': FirebaseAuth.instance.currentUser!.uid,
          'gameState' : stateToJson(GameState.initial(2)),

        };
        FirebaseFirestore.instance.collection('games').doc(inviteID).set(data);
      });
    });
  }

  void updateGameState(String gameID, GameState state) {
    var reference = FirebaseFirestore.instance.collection('games').doc(gameID).withConverter(
        fromFirestore: (snapshot, _) => stateFromJson(snapshot.data()!),
        toFirestore: (model, _) => stateToJson(model),
    );
    reference.set(state, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<GameState>> getGameStream(String gameID) {
    return FirebaseFirestore.instance
              .collection('games').doc(gameID).withConverter(
                fromFirestore: (snapshot, _) => stateFromJson(snapshot.data()!),
                toFirestore: (model, _) => stateToJson(model),
          ).snapshots();
  }

  //JSON serialization and deserialization of game state
  GameState stateFromJson(Map<String, dynamic> json) => GameState(
      legEnded: json['gameState']['legEnded'] as bool,
      currentPlayer: json['gameState']['currentPlayer'] as int,
      visits: _deserializeVisits(json['gameState']['visits'] as Map<String, dynamic>)
  );

  Map<String, dynamic> stateToJson(GameState state) => <String, dynamic>{
    'gameState': {
      'legEnded': state.legEnded,
      'currentPlayer': state.currentPlayer,
      'visits': _serializeVisits(state)
    }
  };

  Map<String, dynamic> _serializeVisits(GameState state) {
    Map<String, dynamic> result = {};
    for (var listOfVisits in state.visits) {
      result[state.visits.indexOf(listOfVisits).toString()] = List<String>.from(listOfVisits.map((e) => e.toString()));
    }
    return result;
  }

  List<List<Visit>> _deserializeVisits(Map<String, dynamic> json) {
    List<List<Visit>> result = [];
    for(var key in json.keys) {
      List<Visit> innerList = [];
      for (var value in json[key] as List<dynamic>) {
        innerList.add(Visit(score: [], isBusted: false).fromString(value as String));
      }
      result.add(innerList);
    }
    return result;
  }
}