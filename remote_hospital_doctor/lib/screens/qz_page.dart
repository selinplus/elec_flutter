import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/prescription/qz_component.dart';
import 'package:remote_hospital_doctor/components/common/scrawl_painter.dart';
import'package:remote_hospital_doctor/services/image_upload_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/screens/sign_page.dart';




class QzPage extends StatefulWidget {
  @override
  _QzPageState createState() => _QzPageState();
}

class _QzPageState extends State<QzPage> {
  bool hasSigned =false;
  bool hasTapSave=false;
  static final List<Color> colors = [
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
  ];
  static final List<double> lineWidths = [5.0, 8.0, 10.0];
  bool isClear = false;
  Color selectedColor = colors[0];
  int selectedLine = 2;
  int curFrame = 0;
  double get strokeWidth => lineWidths[selectedLine];
  List<Point> points = [Point(colors[0], lineWidths[0], [])];
  GlobalKey _globalKey =GlobalKey();

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
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("手写签名",style: TextStyle(fontSize: 18,color: Colors.white)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
//              leading:  GestureDetector(
//                  onTap: (){
//                    setState(() {
//                      reset();
//                    });
//                  },
//                  child: Container(
//                    padding: EdgeInsets.only(left: 20.0),
////                    height: 40,
//                    width: 120,
//                    color: Colors.red,
//                    alignment: Alignment.center,
//                    child:Text("清除"),
//                  )
//              ),
              actions: <Widget>[
                GestureDetector(
                      onTap: (){
                        setState(() {
                          reset();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 30.0),
                        padding: EdgeInsets.only(left: 20.0,right: 20.0),
    //                    height: 40,
                        width: 80,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child:Text("清除"),
                      )
                  ),
                GestureDetector(
                    onTap: (){
                      if(hasTapSave){
                        return;
                      }
                      if(!hasSigned){
                        Fluttertoast.showToast(
                            msg: '还未签名，无法保存',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white
                        );
                        return;
                      }
                      hasTapSave =true;
                      RenderRepaintBoundary boundary =
                      _globalKey.currentContext.findRenderObject();
                      upLoadPng(boundary,fail: (){
                        Fluttertoast.showToast(
                            msg: '签名失败',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white
                        );
                      }).then((val){
                         if(val!=null){
                           print("111111111111"+val);
//                           Navigator.push(context, MaterialPageRoute(builder: (context) {
//                             //指定跳转的页面
//                             return SignPage(title: "签名",imageUrl: val,);
//                           },));

                           Navigator.pop(context,val);
                         }else{
                           print("error");
                         }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left:20,right: 20.0),
                      height: 40,
                      width: 80,
                      color:Colors.transparent,
                      alignment: Alignment.center,
                      child:Text("确定"),
                    )
                ),
              ],
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body:Container(
          child: RepaintBoundary(
            key:_globalKey,
            child: Container(
              child: _buildCanvas(),//
//              decoration: BoxDecoration(
//                 border: Border.all(color: Colors.red,width: 3.0)
//              ),// ,
            ),
          ),
        )
    );
  }

  void reset() {
    hasSigned=false;
    isClear = true;
    curFrame = 0;
    points.clear();
    points.add(Point(selectedColor, strokeWidth, []));
  }

  Widget _buildCanvas() {
    return StatefulBuilder(builder: (context, state) {
      return CustomPaint(
        painter: ScrawlPainter(
          points: points,
          strokeColor: selectedColor,
          strokeWidth: strokeWidth,
          isClear: isClear,
        ),
        child: GestureDetector(
          onPanStart: (details) {
            // before painting, set color & strokeWidth.
            isClear = false;
            points[curFrame].color = selectedColor;
            points[curFrame].strokeWidth = strokeWidth;
          },
          onPanUpdate: (details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
            state(() {
              points[curFrame].points.add(localPosition);
              hasSigned=true;
            });
          },
          onPanEnd: (details) {
            // preparing for next line painting.
            points.add(Point(selectedColor, strokeWidth, []));
            curFrame++;
          },
        ),
      );
    });
  }
}

