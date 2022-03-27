import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xogame/component/info_dialog.dart';
import 'package:xogame/provider/wifi_player_provider.dart';
import 'package:xogame/screens/finder.dart';
import 'component/board_base.dart';
import 'helper/connect_handler.dart';
import 'helper/getit.dart';
import 'helper/preferences.dart';
import 'helper/shared.dart';
import 'provider/base_board.dart';
import 'provider/computer_player_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(fontFamily: "Waree", brightness: Brightness.dark),
      home: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    Key? key,
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
      GetIt.instance
          .registerLazySingleton<SharedPref>(() => SharedPref(prefs: pref));
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
    Completer<bool> completer = Completer<bool>();
    //   String value = "";
    final connModel = ConnectHandlerModel.fromJson(body);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "${connModel.name == "" ? 'player' : connModel.name} want play tictactoc with you"),
            content: const InfoDialog(),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  completer.complete(true);

                  final wifiProvider = WifiPlayerProvider(false,
                      getGetit<SharedPref>().get("myplayer") as String? ?? "o",
                      hisConnectInfo: connModel);
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BoardBulider(
                                baseBoard: wifiProvider,
                              )));
                },
                child: const Text("accept"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  completer.complete(false);
                },
                child: const Text("disaccept"),
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
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
                child: const Text("Human vs Human"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BoardBulider(
                              baseBoard: BaseBoard(true),
                            )),
                  );
                }),
            TextButton(
                child: const Text("Human Vs Computer"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BoardBulider(
                              baseBoard: ComputerPlayerProvider("o"),
                            )),
                  );
                }),
            // TextButton(
            //     child: Text("Two board "),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => TwoBoard()),
            //       );
            //     }),
            TextButton(
                child: const Text("Wifi Play"),
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
