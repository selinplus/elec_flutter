import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QzComponent extends StatefulWidget {
  @override
  _QzComponentState createState() => _QzComponentState();
}

class _QzComponentState extends State<QzComponent> {
  GlobalKey _globalKey =GlobalKey();
  List<Offset> _points = List<Offset>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.red,
        child:GestureDetector(
          onPanUpdate: (DragUpdateDetails details){
            setState(() {
              RenderBox  obj = context.findRenderObject();
              Offset _localPosition = obj.globalToLocal(details.globalPosition);
              _points=List.from(_points)
                ..add(_localPosition);
            });
          },
          onPanEnd:(DragEndDetails details)=>_points..add(null),
          child:  CustomPaint(
            painter:Signature(_points),
            size: Size.infinite,
          ),
        )
    );
  }
}
class Signature extends CustomPainter{
  List<Offset> points;
  Signature(this.points);
  @override
  void paint(Canvas canvas, Size size){
    Paint paint = Paint()
      ..color=Colors.black
      ..strokeCap=StrokeCap.round
      ..strokeWidth=5.0;
    for (int i = 0; i < points.length-1; i++) {
      if (points[i] != null && points[i+1] != null){
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }
  @override
  bool shouldRepaint(Signature oldDelegate){
    oldDelegate.points != points;
  }
}



