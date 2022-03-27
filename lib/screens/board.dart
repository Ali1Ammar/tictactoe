import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xogame/component/line_custom.dart';
import 'package:xogame/provider/base_board.dart';
// 1 2 3
// 4 5 6
// 7 8 9

class BoardView extends StatefulWidget {
  final BaseBoard baseBoard;
  const BoardView({Key? key, required this.baseBoard}) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseBoard>(
      key: UniqueKey(),//TODO
      create: (_) => widget.baseBoard,
      child: Consumer<BaseBoard>(
        builder: (BuildContext context, BaseBoard board, _) => Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft, // player
                child: 
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(board.messegStatus),
                        Text(
                         "${ board.isXPlayer ? "x" : "o"} player"
                        )
                      ],
                    )
              ),
            ),
            Expanded(
              child: FittedBox(
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
                child: Container(
                    padding: const EdgeInsets.all(30),
                    height: 1000,
                    width: 1000,
                    child: Stack(
                      children: <Widget>[
                        GridView.count(
                          crossAxisCount: 3,
                          children: <Widget>[
                            for (var i = 0; i < 9; i++) buildContainer(board, i)
                          ],
                        ),
                        if (board.winner != null)
                          CustomPaint(
                            painter: LinePainter(
                                board.finalWinner![0], board.finalWinner![2]),
                            size: Size.square(
                                MediaQuery.of(context).size.width < 1000
                                    ? 1000
                                    : MediaQuery.of(context).size.width),
                          ),
                      ],
                    )
                    //  Wrap(
                    //   children: <Widget>[
                    //     for (var i = 0; i < 9; i++) buildContainer(board, i)
                    //   ],
                    // ),
                    ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: board.init,
                  child: const CircleAvatar(
                    child: Icon(Icons.refresh),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainer(BaseBoard board, int i) {
    //childAspectRatio
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        child: board.getState()[i] == null
            ? TextButton(
                onPressed: () {
                  if (board.isEnd) return;
                  board.changeState(i);
                },
                child: const SizedBox(),//TODO
              )
            : Center(
                child: Text(
                  board.getState()[i],
                  style: const TextStyle(fontSize: 100),
                ),
              ),
      ),
    );
  }

// 1 2 3
// 4 5 6
// 7 8 9
  Size getSize() => MediaQuery.of(context).size;
}
