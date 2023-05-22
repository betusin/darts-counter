import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/model/firebase_game.dart';
import 'package:dartboard/model/game_notifier.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/game_state.dart';
import '../model/visit.dart';
import 'ioc_container.dart';

class GameService {
  final _userService = get<SetupUserService>();

  Future<List<String>> getPlayerNames(String gameID) async {
    //first game host starts, so return [host, receiver]
    List<String> names = [];

    //cycle until the names are found - this function can potencially run before the doc with the game and names is created
    //maybe a better way of doing this, but couldnt figure it out
    while (names.isEmpty) {
      await FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .get()
          .then((doc) async {
        if (doc.exists) {
          var players = doc.get('playerUIDs');
          for (var playerUID in players) {
            var playerHash = await _userService.getUserHash(playerUID);
            names.add(playerHash);
          }
        }
      });
      await Future.delayed(Duration(microseconds: 300));
    }

    return names;
  }

  void createGame(String inviteID, String hostHash) {
    _userService.getUserUID(hostHash).then((hostUID) {
      _userService.getUserHashOfCurrentUser().then((receiverHash) {
        var players = [hostUID, FirebaseAuth.instance.currentUser!.uid];

        var data = {
          'startedAt': DateTime.now(),
          'playerUIDs': players,
        };
        FirebaseFirestore.instance.collection('games').doc(inviteID).set(data);
        //and set the initial state
        updateGameState(inviteID, GameState.initial(2));
      });
    });
  }

  Future<void> saveLocalGame(int indexToSaveStats, GameNotifier game) async {
    print("Player index: $indexToSaveStats");

    var players =
        await _generatePlayersOfLocalGame(indexToSaveStats, game.playerNames);

    _userService.getUserHashOfCurrentUser().then((hostHash) {
      var data = {
        'startedAt': DateTime.now(),
        'playerUIDs': players,
      };
      var docRef = FirebaseFirestore.instance.collection('games').doc();
      print("Game saved (ID: ${docRef.id})");

      docRef
          .set(data)
          .then((value) => updateGameState(docRef.id, game.currentGame.state));
    });
  }

  List<String> _generatePlayersOfLocalGame(
      int indexToSaveStats, List<String> playerNames) {
    List<String> players = [];

    playerNames.asMap().forEach((index, playerName) {
      if (index == indexToSaveStats) {
        players.add(FirebaseAuth.instance.currentUser!.uid);
      } else {
        players.add("");
      }
    });

    return players;
  }

  void updateGameState(String gameID, GameState state) {
    var reference = FirebaseFirestore.instance
        .collection('games')
        .doc(gameID)
        .withConverter(
          fromFirestore: (snapshot, _) => stateFromJson(snapshot.data()!),
          toFirestore: (model, _) => stateToJson(model),
        );
    reference.set(state, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<GameState>> getGameStream(String gameID) {
    return FirebaseFirestore.instance
        .collection('games')
        .doc(gameID)
        .withConverter(
          fromFirestore: (snapshot, _) => stateFromJson(snapshot.data()!),
          toFirestore: (model, _) => stateToJson(model),
        )
        .snapshots();
  }

  Future<QuerySnapshot<FirebaseGame>> getAllGamesOfCurrentPlayer() {
    var playerID = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('games')
        .where('playerUIDs', arrayContains: playerID)
        .withConverter(
          fromFirestore: (snapshot, _) => gameFromJson(snapshot.data()!),
          toFirestore: (model, _) => gameToJson(model),
        )
        .get();
  }

  //JSON serialization and deserialization of game
  FirebaseGame gameFromJson(Map<String, dynamic> json) {
    return FirebaseGame(
      gameState: stateFromJson(json),
      playerUIDs:
          List<String>.from(json['playerUIDs'].map((e) => e.toString())),
    );
  }

  Map<String, dynamic> gameToJson(FirebaseGame game) => <String, dynamic>{
        'gameState': stateToJson(game.gameState),
        'playerUIDs': game.playerUIDs,
      };

  //JSON serialization and deserialization of game state
  GameState stateFromJson(Map<String, dynamic> json) {
    if (json['gameState'] == null) return GameState.initial(2);
    return GameState(
        legEnded: json['gameState']['legEnded'] as bool,
        currentPlayer: json['gameState']['currentPlayer'] as int,
        visits: _deserializeVisits(
            json['gameState']['visits'] as Map<String, dynamic>));
  }

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
      result[state.visits.indexOf(listOfVisits).toString()] =
          List<String>.from(listOfVisits.map((e) => e.toString()));
    }
    return result;
  }

  List<List<Visit>> _deserializeVisits(Map<String, dynamic> json) {
    List<List<Visit>> result = [];
    for (var key in json.keys) {
      List<Visit> innerList = [];
      for (var value in json[key] as List<dynamic>) {
        innerList
            .add(Visit(score: [], isBusted: false).fromString(value as String));
      }
      result.add(innerList);
    }
    return result;
  }
}
