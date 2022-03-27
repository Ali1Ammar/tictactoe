import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final int x;
  final int y;
  LinePainter(this.x, this.y);
  @override
  void paint(Canvas canvas, Size size) {
    // var rect = Offset.zero & size;

    // Paint rectPaint = Paint();
    // rectPaint.invertColors = false;
    // canvas.drawRect(rect, rectPaint);
// 1 2 3
// 4 5 6
// 7 8 9
    // [1, 2, 3],
    // [4, 5, 6],
    // [7, 8, 9],
    // [1, 4, 7],
    // [2, 5, 8],
    // [3, 6, 9],
    // [1, 5, 9],
    // [3, 5, 7],
  
    canvas.drawLine(_startOffset(size,x), _startOffset(size,y), _paint(Colors.white));
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LinePainter oldDelegate) => false;

   _startOffset(Size size,x,){
     var width = size.width ;
     var padding = width/6  ;
     if(x ==1) return Offset(padding,padding);
     if(x ==2) return Offset(width/2,padding);
     if(x ==3) return Offset(width-padding,padding);
     if(x ==4) return Offset(padding,width/2);
     if(x ==6) return Offset(width-padding,width/2);
     if(x ==7) return Offset(padding,width-padding);
     if(x ==8) return Offset(width/2,width-padding);
     if(x ==9) return Offset(width-padding,width-padding);
  }

  

  _paint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
  }
}
