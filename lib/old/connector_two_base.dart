// import 'package:xogame/helper/connector.dart';

// class ConntectorTwo {
//   final BaseConnector first;
//   final BaseConnector second;

//   ConntectorTwo(this.first, this.second) {

//     first.sender.stream.listen((data) {
//    //   print("sender");
//       second.reciver.sink.add(data);
//     });

//     second.sender.stream.listen((data) {
//       first.reciver.sink.add(data);
//     });
//   }

//   dispose(){
//     print("dispose");
//     first.dispose();
//     second.dispose();
//   }
// }
