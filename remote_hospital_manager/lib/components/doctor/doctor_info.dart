import 'package:flutter/material.dart';
import 'package:remote_hospital_manager/screens/doctor_detail_page.dart';
//import 'package:remote_hospital/screens/doctor_detail_page.dart';
//import 'package:remote_hospital_/config.dart';
import '../../models/doctor.dart';
class DoctorInfoComponent extends StatelessWidget {
  @required Doctor doctor;
  @required final callback;
  DoctorInfoComponent({this.doctor,this.callback});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){
//            if(Navigator.canPop(context)){
//              Navigator.pop(context,doctor);
//            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //指定跳转的页面
                return DoctorDetailPage(doctor:doctor);
              },)).then((_){
                       callback();
              });
//            }
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
                            backgroundImage:doctor.avator_uri==null||doctor.avator_uri==""?null:NetworkImage("${doctor.avator_uri}")//AssetImage('assets/images/doctor.jpg'),//
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ),

                    ],
                  ) ,

                ),
                Container(
                    padding: EdgeInsets.only(right:10.0,top:2.0),
                    alignment: Alignment.topRight,
                    height: 80.0,
                    width: 100.0,
                    child:Text(doctor.review?"已审核":"未审核", style: TextStyle(fontSize: 10,color: Theme.of(context).accentColor),)
                ),
              ],
            ),
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
