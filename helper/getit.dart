import 'package:get_it/get_it.dart';

void setupGetit() {
//  GetIt.instance.registerSingleton<Info>(Info());
//  GetIt.instance.registerSingleton<ConnectorHandlerProvider>(ConnectorHandlerProvider());
}

T getGetit<T>() {
  return GetIt.instance.get<T>();
  
}
