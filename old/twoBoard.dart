// import 'package:flutter/material.dart';
// import 'package:xogame/helper/connect_handler.dart';
// import 'package:xogame/helper/connectorTwoBase.dart';
// import 'package:xogame/provider/wifiPlayerProvider.dart';
// import 'package:xogame/screens/board.dart';

// class TwoBoard extends StatefulWidget {

//   TwoBoard({Key key}) : super(key: key);
//    final WifiPlayerProvider wifiPlayerProvider1 = WifiPlayerProvider(true,"o",hisConnectInfo: ConnectHandlerModel(name: "") );
//    final WifiPlayerProvider wifiPlayerProvider2 =  WifiPlayerProvider(false,"x",hisConnectInfo: ConnectHandlerModel()) ;

//   @override
//   _TwoBoardState createState() => _TwoBoardState();
// }

// class _TwoBoardState extends State<TwoBoard> {
//   ConntectorTwo conntectorTwo ;
// @override
// void dispose() { 
//   conntectorTwo.dispose();
//   super.dispose();
// }
// @override
//   void initState() {
//    conntectorTwo= ConntectorTwo(widget.wifiPlayerProvider1.connector,widget.wifiPlayerProvider2.connector) ;

  
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Row(
//         children: <Widget>[ 
//           Expanded(
//             child: BoardView(
//               baseBoard: widget.wifiPlayerProvider1,
            
//             ),
//           ),
//           Expanded(
//             child: BoardView(
//               baseBoard: widget.wifiPlayerProvider2,
            
//             ),
//           )
//         ],
//       ),
      
//     );
//   }
// }
