import 'package:get_it/get_it.dart';

void setupGetit() {
//  GetIt.instance.registerSingleton<Info>(Info());
//  GetIt.instance.registerSingleton<ConnectorHandlerProvider>(ConnectorHandlerProvider());
}

T getGetit<T extends Object>() {
  return GetIt.instance.get<T>();
}
