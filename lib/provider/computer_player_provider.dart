import 'dart:math';
import 'base_board.dart';

class ComputerPlayerProvider extends BaseBoard {
  final String computerWord;
  ComputerPlayerProvider(this.computerWord) : super(computerWord != "x");

  @override
  void changeState(int indexState) {
    if (!isMyTurn) return;
    super.changeState(indexState);
    if (computerWord == player && !isEnd) {
      isMyTurn = false;
      computerchangeState().then((_) {
        isMyTurn = true;
      });
    }
  }

  Future computerchangeState() async {
    List tempList = getState();
    int nextMove = Random().nextInt(8);
    while (tempList[nextMove] != null) {
      if (nextMove == 8) {
        nextMove = 0;
        continue;
      }
      nextMove++;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    super.changeState(nextMove);
  }
}
