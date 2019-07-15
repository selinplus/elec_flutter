import 'package:flutter/material.dart';
class ZlxzRowComponent extends StatelessWidget {
  String zlxz;
  final callback;
  ZlxzRowComponent({this.zlxz,this.callback});
  onChange(val){
    callback(val);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              padding:EdgeInsets.only(left: 10.0) ,
              alignment: Alignment.centerLeft,
              width: 90.0,
              height: 40.0,
              child:Text("*诊疗性质",style: TextStyle(fontSize: 12))
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:EdgeInsets.only(left: 10.0) ,
            width: 30,
            height: 40.0,
            child: Radio(
              value:"0",
              groupValue: zlxz,
              onChanged: (T){
                onChange(T);
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:EdgeInsets.only(left: 10.0) ,
            width: 80.0,
            child: Text("初诊",style: TextStyle(fontSize: 12)),
          ),
          Container(
//            color: Colors.red,
            padding:EdgeInsets.only(left: 10.0) ,
            alignment: Alignment.centerLeft,
            width: 30,
            height: 40.0,
            child: Radio(
              value:"1",
              groupValue: zlxz,
              onChanged: (T){
                onChange(T);
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:EdgeInsets.only(left: 10.0) ,
            width: 80.0,
            child: Text("复诊",style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
