import 'dart:convert';
import 'dart:math' as Math;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xogame/helper/preferences.dart';
import 'package:xogame/helper/shared.dart';
import 'package:xogame/provider/connector.dart';
import 'getit.dart';

class Service {
  static void init() async {
    final service = Service();
    final server = await shelf_io.serve(
        service.handler, await ConnectorInfo.myAddress, 8080);
    print('Server running on localhost:${server.port}');
  }

  Handler get handler {
    final router = Router();

    router.get('/name', (Request request) {
      return Response.ok(
          jsonEncode({"name": getGetit<SharedPref>().get("name") ?? ""}));
    });
    router.post('/connect', (Request request) async {
      Map<String, dynamic> body = jsonDecode(await request.readAsString());
      final isOk = await getGetit<alertFunction>()(body);
      if (!isOk) Response.forbidden("");
      Map res = {
        "ip": await ConnectorInfo.myAddress,
        "name": getGetit<SharedPref>().get("name") ?? "",
        "token": Math.Random().nextInt(100)
      };
      return Response.ok(jsonEncode(res));
    });

    router.get('/move/<index>', (Request request, String index) {
      print("request on $index");
      getGetit<changeStateFunction>()(int.parse(index));
      return Response.ok('');
    });

    return router ;
  }
}
