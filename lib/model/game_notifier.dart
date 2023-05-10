import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartboard/model/online_game_service.dart';
import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import '../service/ioc_container.dart';
import '../service/setup_user_service.dart';
import 'game_service.dart';
import 'local_game_service.dart';

/*
TODO finish support for online game
 */
class GameNotifier extends ChangeNotifier {
  final _userService = get<SetupUserService>();
  GameService currentGame = LocalGameService();

  int numberOfPlayers = 2;
  List<String> playerNames = [];
  int startingScore = 501;
  List<int> victories = [];
  String onlineGameID = '';

  void createNewOnlineGame({required String gameID, bool starting = false}) async {

    currentGame = OnlineGameService(gameID: gameID, starting: starting, notifyCallback: notifyListeners);
    onlineGameID = gameID;
    numberOfPlayers = 2;
    startingScore = 501;
    victories = List.filled(2, 0, growable: true);

    playerNames = ['ME', 'OPPONENT'];
    _setPlayerNames();
  }

  void _setPlayerNames() async {  //TODO get opponents name
    String myHash = await _userService.getUserHashOfCurrentUser();
    playerNames[0] = myHash;
    notifyListeners();
  }

  void createNewLocalGame({required int number, required List<String> names, int starting = 501}) {
    currentGame = LocalGameService(players: number, startingScore: starting);
    numberOfPlayers = number;
    playerNames = names;
    startingScore = starting;
    victories = List.filled(number, 0, growable: true);
  }

  void newGameSamePlayers() {
    victories[currentGame.getWinnerIndex()] += 1;
    String pom = playerNames.removeLast();
    playerNames.insert(0, pom);
    victories.insert(0, victories.removeLast());
    currentGame = LocalGameService(players: numberOfPlayers, startingScore: startingScore);
    notifyListeners();
  }

  void stepBack() {
    currentGame.stepBack();
    notifyListeners();
  }

  void addThrow(int score, bool isDouble) {
    currentGame.addNewScore(score, isDouble);
    notifyListeners();
  }

  void confirmTurn() {
    currentGame.confirmTurn();
  }

  int getScore(int index) {
    return currentGame.getCurrentScore(index);
  }

  double getAverage(int index) {
    return currentGame.getCurrentAverage(index);
  }

  Visit getVisit(int index) {
    return currentGame.getCurrentVisit(index);
  }

  bool isMyTurn(int index) {
    return currentGame.isMyTurn(index);
  }

  bool getGameOver() {
    return currentGame.getLegEnded();
  }

  String getName(int index) {
    return playerNames[index];
  }

  String getWinnerName() {
    if (!currentGame.getLegEnded()) return '';
    return playerNames[currentGame.getWinnerIndex()];
  }

  int getCurrentScore() {
    return currentGame.getCurrentPlayerScore();
  }

  int getNumberOfPlayers() {
    return numberOfPlayers;
  }

  int getCurrentPlayerIndex() {
    return currentGame.getCurrentIndex();
  }

  int getVictories(int index) {
    return victories[index];
  }

  bool awaitingConfirmation() {
    return currentGame.awaitingConfirmation();
  }
}
