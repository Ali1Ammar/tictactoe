
import 'package:flutter/material.dart';

import 'home.dart';

import 'helper/server.dart';
import 'helper/getit.dart';

void main() {
  setupGetit();
  Service.init();

  runApp(const HomePage());
}
