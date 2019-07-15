import 'package:flutter/material.dart';
import './password_edit_row_component.dart';
import './password_edit_button_component.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/screens/identified_page.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
class AccountIdentifiedComponent extends StatelessWidget {
  Doctor doctor;
  AccountIdentifiedComponent({this.doctor});
  _onPasswordChange(val){
    //callback(val);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          //指定跳转的页面
          return IdentifiedPage(doctor: doctor,);
        },));
      },
      child: Container(
          color:Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                  child: Container(
//             color: Colors.blue,
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    height: 40.0,
                    child: Text("身份认证", style: TextStyle(fontSize: 14),
                    ),
                  )//
              ),
              Container(
                padding: EdgeInsets.only(right:10.0),
                child: Icon(Icons.arrow_forward_ios,size: 14.0,color: Theme.of(context).accentColor),
              )
            ],
          )
      )
    );

  }
}







