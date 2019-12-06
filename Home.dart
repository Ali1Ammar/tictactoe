import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xogame/component/info_dialog.dart';
import 'package:xogame/provider/wifiPlayerProvider.dart';
import 'package:xogame/screens/finder.dart';
import 'component/boardBase.dart';
import 'helper/connect_handler.dart';
import 'helper/getit.dart';
import 'helper/preferences.dart';
import 'helper/shared.dart';
import 'provider/base_board.dart';
import 'provider/ComputerPlayerProvider.dart';
import 'screens/board.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(fontFamily: "Waree", brightness: Brightness.dark),
      home: new HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key key,
  }) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // final StreamController streamController =
  //     getGetit<ConnectorHandlerProvider>();

  @override
  void initState() {
    GetIt.instance.registerSingleton<alertFunction>(alertDilog);
    SharedPreferences.getInstance().then((pref) {
      print(
          "done SharedPreferencesSharedPreferencesSharedPreferencesSharedPreferences");
      GetIt.instance
          .registerLazySingleton<SharedPref>(() => SharedPref(prefs: pref));
    }).catchError((_) {
      GetIt.instance.registerLazySingleton<SharedPref>(() => SharedPref());
    });

    super.initState();
  }

  @override
  void dispose() {
    //  streamController.close();
    super.dispose();
  }

  Future<bool> alertDilog(Map<String, dynamic> body) {
    // bool isEnd = false;
    Completer completer = new Completer<bool>();
    //   String value = "";
    final connModel = ConnectHandlerModel.fromJson(body);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${connModel.name=="" ? 'player' : connModel.name} want play tictactoc with you"),
            content: InfoDialog(),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  completer.complete(true);
                  print(body);

                  final wifiProvider = WifiPlayerProvider(
                      false, getGetit<SharedPref>().get("myplayer") ?? "o",
                      hisConnectInfo: connModel);
                        Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BoardBulider(
                                baseBoard: wifiProvider,
                              )));
                            
                },
                child: Text("accept"),
              ),
              FlatButton(
                onPressed: () {
                    Navigator.pop(context);
                  completer.complete(false);
                },
                child: Text("disaccept"),
              )
            ],
          );
        });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                child: Text("Human vs Human"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new BoardBulider(
                              baseBoard: BaseBoard(true),
                            )),
                  );
                }),
            FlatButton(
                child: Text("Human Vs Computer"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BoardBulider(
                              baseBoard: ComputerPlayerProvider("o"),
                            )),
                  );
                }),
            // FlatButton(
            //     child: Text("Two board "),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => TwoBoard()),
            //       );
            //     }),
            FlatButton(
                child: Text("Wifi Play"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinderPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
