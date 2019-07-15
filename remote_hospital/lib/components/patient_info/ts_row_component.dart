import 'package:flutter/material.dart';
class TsRowComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.centerLeft,
      padding:EdgeInsets.only(left: 10.0) ,
      color:Colors.grey[100],
      child: Text("请如实填写患者病例信息，带*为必填",style: TextStyle(fontSize: 12,color: Colors.red)),
    );
  }
}
