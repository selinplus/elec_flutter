import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../screens/patient_info_page.dart';
class WzyhComponent extends StatelessWidget {
  Patient user;
  WzyhComponent(this.user);
  _enterYhxx(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return PatientInfoPage(user);
    },));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 90.0,
//              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Text("${user.name}",style: TextStyle(fontSize: 12)),
            ),
            Container(
              height: 40.0,
              width: 120.0,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Text("${user.sex=='1'?'男':user.sex=='0'?'女':''}",style: TextStyle(fontSize: 12)),
            ),
            Container(
              height: 40.0,
              width: 60.0,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Text("${user.married=='1'?'已婚':user.married=='0'?'未婚':''}",style: TextStyle(fontSize: 12)),
            ),
            Expanded(
              child: Container(
                height: 40.0,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.0),
                child: Text("${user.birthday}",style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        Divider(height: 1.0, ),
        Row(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 90.0,
//              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Text("联系电话",style: TextStyle(fontSize: 12)),
            ),
            Expanded(
              child: Container(
                height: 40.0,
                width: 90.0,
//              color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.0),
                child: Text("${user.mobile}",style: TextStyle(fontSize: 12)),
              ),
            ),
            Container(
              height: 40.0,
              width: 60.0,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(bottom:8.0,top: 8.0),
              margin: EdgeInsets.only(right:10) ,
              child: RaisedButton(
                padding: EdgeInsets.only(left:0.0,right: 0.0),
                textColor: Theme
                    .of(context)
                    .accentColor,
                child: Text("问  诊",style: TextStyle(fontSize: 12)),
                color:Colors.white,
                shape: Border.all(
                    color:Theme.of(context).accentColor,
                    width: 1.0,
                    style: BorderStyle.solid
                ),
                onPressed: () {
                  _enterYhxx(context);
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
