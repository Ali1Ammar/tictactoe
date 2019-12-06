import 'package:flutter/material.dart';
import 'package:xogame/provider/base_board.dart';
import 'package:xogame/screens/board.dart';

class BoardBulider extends StatelessWidget {
  final BaseBoard baseBoard;
  const BoardBulider({Key key, this.baseBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BoardView(
        baseBoard: baseBoard,
      ),
    );
  }
}
