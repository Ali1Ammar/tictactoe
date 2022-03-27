import 'package:flutter/material.dart';

class ConnectHandlerModel {
  String address; 
  String name;
  int token;
  ConnectHandlerModel(
      {@required this.address, @required this.name, @required this.token});
  static ConnectHandlerModel fromJson(Map data) => ConnectHandlerModel(
      address: data["ip"], name: data["name"] , token: data["token"]);
  Map toJson() => {"ip": address, "name": name, "token": token};
}
