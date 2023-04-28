import 'package:collection/collection.dart';
/*
class representing one visit of a player (one turn) -> three darts thrown
 */
class Visit {
  final List<int> score;
  final bool isBusted;

  const Visit({required this.score, required this.isBusted});

  Visit addThrow(int newScore) {
    List<int> newList = List.from(score);
    newList.add(newScore);
    return Visit(score: newList, isBusted: isBusted);
  }

  Visit bust() {
    return Visit(score: List.from(score), isBusted: true);
  }

  int getDarts() {
    return score.length;
  }

  int getTotal() {
    return score.sum;
  }

  int getLast(){
    if (score.isEmpty){
      return 0;
    }
    return score.last;
  }

  bool isFull() {
    return (score.length == 3);
  }

  bool isEmpty() {
    return (score.isEmpty);
  }

  String getFirst() {
    if (score.isEmpty) {
      return "";
    }
    return score[0].toString();
  }

  String getSecond() {
    if (score.length < 2) {
      return "";
    }
    return score[1].toString();
  }

  String getThird() {
    if (score.length < 3) {
      return "";
    }
    return score[2].toString();
  }
}