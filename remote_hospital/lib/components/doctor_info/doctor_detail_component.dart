import 'package:flutter/material.dart';
import 'package:remote_hospital/config.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/doctor.dart';
import 'package:remote_hospital/event/event_bus.dart';
class DoctorDetailComponent extends StatelessWidget {
  @required Doctor doctor;
  final sendToDoctor;
  final callDoctor;
  @required bool havaSendedToDoctor;
  final bool isDisplaySendToDoctor;
  DoctorDetailComponent({this.doctor,this.sendToDoctor,this.callDoctor,this.havaSendedToDoctor,this.isDisplaySendToDoctor});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){
          },
          child: Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10.0),
                    height: 80.0,
                    width: 80.0,
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                            radius: 36.0,
                            backgroundImage: doctor.avator_uri==null||doctor.avator_uri==""?null:NetworkImage("${doctor.avator_uri}")//AssetImage('assets/images/doctor.jpg'),
                        ),
                        CheckedIcon(doctor.review),
                      ],
                    )
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 25,
                        padding: EdgeInsets.only(right:10.0),
                        alignment: Alignment.centerLeft,
                        child: Text("${doctor.name}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        height: 25,
                        padding: EdgeInsets.only(right:10.0),
                        alignment: Alignment.centerLeft,
                        child: Text("${doctor.zydw}",style: TextStyle(fontSize: 12)),
                      ),
                      Container(
                        height: 25,
                        padding: EdgeInsets.only(right:10.0),
                        alignment: Alignment.centerLeft,
                        child: Text("${doctor.dept}",style: TextStyle(fontSize: 12)),
                      ),
                      Container(
                        padding: EdgeInsets.only(right:10.0),
                        alignment: Alignment.topLeft,
                        child: Text("简介：${doctor.jianjie}",
                          style: TextStyle(fontSize: 10,color: Colors.grey),
                          maxLines:100,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ) ,
                ),
                Container(
                  padding: EdgeInsets.only(right:10.0,top:2.0),
                  alignment: Alignment.topRight,
                  height: 80.0,
                  width: 100.0,
//                  child: RichText(
//                    text: TextSpan(
//                      text: "状态： ",
//                      style: TextStyle(fontSize: 10,color: Colors.grey),
//                      children:doctor.zhuangtai==null?null:<TextSpan>[
//                        TextSpan(
//                          text: "${doctor.zhuangtai}",
//                          style: TextStyle(fontSize: 10,color: Theme.of(context).accentColor),
//                        ),
//                        TextSpan(
//                          text: " ",
//                          style: TextStyle(fontSize: 10,color: Colors.grey),
//                        ),
//                      ],
//                    ),
//                  ),
                ),
              ],
            ),
          ),

        ),
        Divider( height: 1.0,),
        Container(
          height: 40,
          //margin: EdgeInsets.only(left:5.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
         // alignment: Alignment.center,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: isDisplaySendToDoctor?RaisedButton(
                  padding: EdgeInsets.only(left:0.0,right: 0.0),
                  textColor: Theme
                      .of(context)
                      .accentColor,
                  child: Text(havaSendedToDoctor?"已发送医师":"发送医师",style: TextStyle(fontSize: 10)),
                  color:Colors.white,
                  shape: Border.all(
                      color:Theme.of(context).accentColor,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  onPressed: havaSendedToDoctor?null:()=>sendToDoctor()
                ):null,
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                  padding: EdgeInsets.only(left:0.0,right: 0.0),
                  textColor: Theme
                      .of(context)
                      .accentColor,
                  child: Text("视频问诊",style: TextStyle(fontSize: 10)),
                  color:Colors.white,
                  shape: Border.all(
                      color:Theme.of(context).accentColor,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  onPressed: ()=>callDoctor()
                ),
              )
            ],
          ),

        ),
      ],
    );
  }
}

class CheckedIcon extends StatelessWidget {
  final bool checked;
  CheckedIcon(this.checked);
  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: Alignment.bottomRight,
        child:checked?Icon(Icons.check_circle,color: Theme.of(context).accentColor,size: 14.0,):null
    );
  }
}
