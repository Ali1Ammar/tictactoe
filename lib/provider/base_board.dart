import 'package:flutter/foundation.dart' show ChangeNotifier;

class BaseBoard extends ChangeNotifier {
  List<String?> _boardState = List.generate(9, (_) => null);
  List<int>? finalWinner;
  static const List<List<int>> _winnerState = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
  ];
  bool isMyTurn = true;
  bool isXPlayer = false;
  bool isEnd = false;
  bool isXFirstPlayer;
  String? winner;
  String get messegStatus {
    return !isEnd
        ? "player :   $player"
        : (winner != null ? "The Player $winner is win" : "there is no winner");
  }

  BaseBoard(this.isXFirstPlayer) {
    isXPlayer = isXFirstPlayer;
  }

  void checkWinner(String playerNow) {
    if (isWinner(playerNow)) {
      isEnd = true;
      winner = playerNow;
    }
    isEndCheck();
    isXPlayer = !isXPlayer;
    notifyListeners();
  }

  bool isEndCheck() {
    if (!isEnd && !_boardState.contains(null)) {
      isEnd = true;
    }
    return isEnd;
  }

  bool isWinner(
    String playerNow,
  ) {
    final boardSatae = _boardState;
    for (final state in _winnerState) {
      if (boardSatae[state[0] - 1] == playerNow &&
          boardSatae[state[1] - 1] == playerNow &&
          boardSatae[state[2] - 1] == playerNow) {
        finalWinner = state;
        return true;
      }
    }
    return false;
  }

  void changeState(int indexState) {
    _boardState[indexState] = isXPlayer ? "x" : "o";
    checkWinner(isXPlayer ? "x" : "o");
  }

  List getState() => _boardState;

  void init() {
    _boardState = List.generate(9, (_) => null);
    isXPlayer = isXFirstPlayer;
    winner = null;
    isEnd = false;
    notifyListeners();
  }

  String get player => isXPlayer ? "x" : "o";
}
