import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xogame/helper/connect_handler.dart';
import 'package:xogame/helper/getit.dart';
import 'package:xogame/helper/preferences.dart';
import 'package:xogame/helper/requset.dart';
import 'package:xogame/helper/shared.dart';
import 'base_board.dart';

class WifiPlayerProvider extends BaseBoard {
  final String myWord; // x or o ;
  String myName = getGetit<SharedPref>().get("name") ?? "my";
  // String hisWord; // x or 0
  bool isMyTurn;
  ConnectHandlerModel hisConnectInfo;
  //BaseConnector connector;
  WifiPlayerProvider(this.isMyTurn, this.myWord,
      {@required this.hisConnectInfo})
      : super((isMyTurn && myWord == "x") || (!isMyTurn && myWord == "o")) {
    //hisWord = myWord == "x" ? "o" : "x";
    //connector = BaseConnector(changeStateOutSide);
    //changeStateFunction
    GetIt.instance.registerSingleton<changeStateFunction>(changeStateOutSide);
  }

  @override
  String get messegStatus {
    if (isEnd) {
      print(winner);
      print(myWord);
      if (winner == myWord) return "you win";
      if (winner == null) return "no winner";
      return "you lost";
    } else {
      if (isMyTurn)
        return "$myName turn";
      else
        return "${hisConnectInfo.name.isEmpty ? 'his' : hisConnectInfo.name} turn";
    }
  }

  @override
  void changeState(int indexState) {
    if (!isMyTurn) return;
    super.changeState(indexState);
    RequestClass.sendMove(hisConnectInfo.address, 8080, indexState);
    isMyTurn = false;
  }

  void changeStateOutSide(int indexState) {
    if (isMyTurn) return;
    super.changeState(indexState);
    isMyTurn = true;
  }

  @override
  void init() {
    // super.init();
  }
}
