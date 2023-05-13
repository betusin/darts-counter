import 'package:dartboard/model/online_game.dart';
import 'package:dartboard/model/visit.dart';
import 'package:flutter/cupertino.dart';

import '../service/game_service.dart';
import '../service/ioc_container.dart';
import 'game.dart';
import 'local_game.dart';

class GameNotifier extends ChangeNotifier {
  final _gameService = get<GameService>();
  Game currentGame = LocalGame(startingScore: 501);

  int numberOfPlayers = 2;
  List<String> playerNames = [];
  int startingScore = 501;
  List<int> victories = [];
  String onlineGameID = '';

  void createNewOnlineGame({required String gameID, int myIndex = 0}) async {
    currentGame = OnlineGame(gameID: gameID, myIndex: myIndex, notifyCallback: notifyListeners);
    onlineGameID = gameID;
    numberOfPlayers = 2;
    startingScore = 501;
    victories = List.filled(2, 0, growable: true);

    playerNames = ['PLAYER1', 'PLAYER2'];
    _setPlayerNames(gameID);
  }

  void _setPlayerNames(String gameID) async {
    playerNames = await _gameService.getPlayerNames(gameID);
    notifyListeners();
  }

  void createNewLocalGame({required int number, required List<String> names, int starting = 501}) {
    currentGame = LocalGame(numberOfPlayers: number, startingScore: starting);
    numberOfPlayers = number;
    playerNames = names;
    startingScore = starting;
    victories = List.filled(number, 0, growable: true);
  }

  void newGameSamePlayers() {
    victories[currentGame.getWinnerIndex()] += 1;
    playerNames.insert(0, playerNames.removeLast());
    victories.insert(0, victories.removeLast());
    currentGame.reset();
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
    notifyListeners();
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
