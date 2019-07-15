import 'package:flutter/material.dart';
import 'package:remote_hospital/screens/doctor_detail_page.dart';
import '../../models/doctor.dart';
class DoctorComponent extends StatelessWidget {
  @required Doctor doctor;
  DoctorComponent(this.doctor);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //指定跳转的页面
              return DoctorDetailPage(doctor:doctor);
            },));
          },
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
                        backgroundImage: AssetImage('assets/images/doctor.jpg'),
                      ),
                      CheckedIcon(true),
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
                      child: Text("山东大学齐鲁医院",style: TextStyle(fontSize: 12)),
                    ),
                    Container(
                      padding: EdgeInsets.only(right:10.0),
                      alignment: Alignment.topLeft,
                      child: Text("擅长：什么都治,什么都治,什么都治,什么都治,什么都治,什么都治,再说一遍什么都治",
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
                  child: RichText(
                    text: TextSpan(
                      text: "排队人数 ",
                      style: TextStyle(fontSize: 10,color: Colors.grey),
                      children:<TextSpan>[
                        TextSpan(
                          text: "100",
                          style: TextStyle(fontSize: 10,color: Theme.of(context).accentColor),
                        ),
                        TextSpan(
                          text: " 人",
                          style: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Divider( height: 1.0,),
        Container(
          height: 30,
          width: 60,
          margin: EdgeInsets.only(left:75.0),
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
            onPressed: () {

            },
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
