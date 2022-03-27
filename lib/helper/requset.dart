import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xogame/helper/preferences.dart';
import 'package:xogame/provider/connector.dart';
import 'dart:math' as math;
import 'getit.dart';

class RequestClass {
  static Future<String> getName(String ip, port) async {
    final res = await http.get(Uri.parse("http://$ip:$port/name"));
    if (res.statusCode != 200) throw Exception("Error not 200 ");
    Map decode = jsonDecode(res.body);
    return decode["name"];
  }

  static Future<Map> sendConnection(String ip, port) async {
    final body = {
      "ip": await ConnectorInfo.myAddress,
      "name": getGetit<SharedPref>().get("name") ?? "",
      "token": math.Random().nextInt(100)
    };
    final res = await http.post(Uri.parse("http://$ip:$port/connect"),
        body: jsonEncode(body));
    if (res.statusCode != 200) throw Exception("Error not 200 ");
    Map decode = jsonDecode(res.body);
    return decode;
  }

  static sendMove(String ip, port, int index) async {
    http.get(Uri.parse("http://$ip:$port/move/$index"));
  }
}
