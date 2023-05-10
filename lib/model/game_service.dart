import 'package:dartboard/model/visit.dart';

abstract class GameService {

  void addNewScore(int score, bool isDouble);

  void stepBack();

  int getCurrentScore(int playerIndex);

  double getCurrentAverage(int playerIndex);

  Visit getCurrentVisit(int index);

  bool isMyTurn(int index);

  int getCurrentPlayerScore();

  bool getLegEnded();

  int getWinnerIndex();

  int getCurrentIndex();

  bool awaitingConfirmation();

  void confirmTurn();
}
