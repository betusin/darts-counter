import 'package:collection/collection.dart';
/*
class representing one visit of a player (one turn) -> three darts thrown
 */
class Visit {
  final List<int> _score = [];
  bool isBusted = false;

  bool addThrow(int score) {
    if (_score.length > 2){
      return false;
    }
    _score.add(score);
    return true;
  }

  bool removeThrow() {
    if (_score.isEmpty){
      return false;
    }
    _score.removeLast();
    return true;
  }

  int getDarts() {
    return _score.length;
  }

  int getTotal() {
    return _score.sum;
  }

  int getLast(){
    if (_score.isEmpty){
      return 0;
    }
    return _score.last;
  }

  bool isFull() {
    return (_score.length == 3);
  }

  bool isEmpty() {
    return (_score.isEmpty);
  }

  String getFirst() {
    if (_score.isEmpty) {
      return "";
    }
    return _score[0].toString();
  }

  String getSecond() {
    if (_score.length < 2) {
      return "";
    }
    return _score[1].toString();
  }

  String getThird() {
    if (_score.length < 3) {
      return "";
    }
    return _score[2].toString();
  }

}