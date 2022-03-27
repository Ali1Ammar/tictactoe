import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
//import 'package:get_ip/get_ip.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:xogame/helper/requset.dart';
//import 'package:wifi/wifi.dart';

class ConnectorInfo extends ChangeNotifier {
  ConnectorInfo() {
    pingNetwork();
  }
  StreamSubscription<NetworkAddress>? subStream;
  static Future<String> myAddress = _getIp(); //Wifi.ip;
  static const port = 8080;
  List<Map<String, String>> listIp = [];

  bool isDone = false;
  pingNetwork() async {
    isDone = false;
    // listIp.clear();
    notifyListeners();
    String ip = await myAddress;
    String subnet = ip.substring(0, ip.lastIndexOf('.'));

    final stream = NetworkAnalyzer.discover2(subnet, port);
    //   .where((NetworkAddress addr) => addr.exists);
    subStream = stream.listen((val) {
      if ("192.168.3.67" == val.ip) {
        print("Yes laptop HEre ${val.exists}");
      }
      if (val.exists) {
        int index = listIp.length;
        listIp.add({"ip": val.ip});
        RequestClass.getName(val.ip, port).then((name) {
          listIp[index]["name"] = name;
        });
        notifyListeners();
      }
    });
    subStream!.onDone(() {
      print("done");
      isDone = true;
      notifyListeners();
    });
  }

  @override
  dispose() {
     subStream?.cancel();
    super.dispose();
  }

  static Future<String> _getIp() async {
    print(NetworkInterface.listSupported);
    // if (Platform.isAndroid)
    //   return "192.168.3.26"; // Wifi.ip;
    // else if (NetworkInterface.listSupported) {
    //   final list = await NetworkInterface.list();
    //   return list[0].addresses[0].address;
    // }
    final list = await NetworkInterface.list();
    return list[0].addresses[0].address;
    //  throw Exception("get ip not support");
  }
}
