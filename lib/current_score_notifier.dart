import 'package:flutter/cupertino.dart';

class CurrentScoreNotifier extends ChangeNotifier{
  String _score = '...';

  void setScore(int score){
    _score = score.toString();
    notifyListeners();
  }

  String getScore(){
    return _score;
  }

}