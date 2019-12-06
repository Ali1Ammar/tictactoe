import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xogame/helper/preferences.dart';
import 'package:xogame/provider/connector.dart';
import 'dart:math' as Math;
import 'getit.dart';

class RequestClass {
  static Future<String> getName(String ip, port) async {
    final res = await http.get("http://$ip:$port/name");
    if (res.statusCode != 200) throw Exception("Error not 200 ");
    Map decode = jsonDecode(res.body);
    return decode["name"];
  }

  static Future<Map> sendConnection(String ip, port) async {
    final body = {
      "ip": await ConnectorInfo.myAddress,
      "name": getGetit<SharedPref>().get("name") ?? "",
      "token": Math.Random().nextInt(100)
    };
    try {
      final res =
          await http.post("http://$ip:$port/connect", body: jsonEncode(body));
      if (res.statusCode != 200) throw Exception("Error not 200 ");
      Map decode = jsonDecode(res.body);
      return decode;
    } catch (e) {
      print(e.toString());
      print("Hiiiiiiiiiiiiiii here");
      throw e;
    }
  }

  static sendMove(String ip, port, int index) async {
    print("http://$ip:$port/move/$index");
    http.get("http://$ip:$port/move/$index");
  }
}
