import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xogame/component/board_base.dart';
import 'package:xogame/component/info_dialog.dart';
import 'package:xogame/helper/connect_handler.dart';
import 'package:xogame/helper/getit.dart';
import 'package:xogame/helper/preferences.dart';
import 'package:xogame/helper/requset.dart';
import 'package:xogame/provider/connector.dart';
import 'package:xogame/provider/wifi_player_provider.dart';

class FinderPage extends StatelessWidget {
  FinderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider<ConnectorInfo>(
          builder: (context) => ConnectorInfo(),
          //   dispose: (context, val) => val.dispose(),
          child: Consumer<ConnectorInfo>(
            builder: (context, ConnectorInfo connectorInfo, _) => Center(
              child: connectorInfo.listIp.length != 0
                  ? ListView.builder(
                      itemCount: connectorInfo.listIp.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(connectorInfo.listIp[index]["ip"]),
                        subtitle: connectorInfo.listIp[index]["name"] == null
                            ? null
                            : Text(connectorInfo.listIp[index]["name"]),
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: InfoDialog(),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Done"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                          print("after dialog ");
                          RequestClass.sendConnection(
                                  connectorInfo.listIp[index]["ip"], 8080)
                              .then((val) {
                            print(val);
                            final connModel = ConnectHandlerModel.fromJson(val);
                            final wifiProvider = WifiPlayerProvider(true,
                                getGetit<SharedPref>().get("myplayer") ?? "x",
                                hisConnectInfo: connModel);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BoardBulider(
                                          baseBoard: wifiProvider,
                                        )));
                          }).catchError((err) {
                            print(err.toString());
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: Text("your request closed"),
                                    ));
                          });
                        },
                      ),
                    )
                  : connectorInfo.isDone
                      ? RaisedButton(
                          onPressed: connectorInfo.pingNetwork,
                          child: Text("no data click to refresh"),
                        )
                      : CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
