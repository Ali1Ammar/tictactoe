// import 'dart:async';
// class BaseConnector {
//   String otherAdress;
//   StreamController reciver = StreamController();
//   StreamController sender = StreamController();
//   final void Function(int indexState) changeState;
//   BaseConnector(this.changeState) {
//     //  print("init");
//    init();
 
//   }

//   sendMove(int index) {
//     // send to otherAdress by hhtp or bluetooth
//     sender.sink.add(index);
//   } // call from here

//   init() { 

//     //http.read("192.168.1.255");
//     reciver.stream.listen((data) {
//       changeState(data);

//     });
//     //reciver.close();
//   }

//   dispose(){ 
     
//     reciver.close();
//     sender.close();
//   }
// }
