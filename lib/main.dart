import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

import 'helper/server.dart';
import 'helper/getit.dart';

void main() {
  setupGetit();
  Service.init();
  Provider.debugCheckInvalidValueType = null;
  if(Platform.isLinux ){
   debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(HomePage());
}
