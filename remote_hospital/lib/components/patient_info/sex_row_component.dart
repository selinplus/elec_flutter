import 'package:flutter/material.dart';
class SexRowComponent extends StatelessWidget {
  final String _sex;
  final callback;
  SexRowComponent(this._sex,{this.callback});
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
              child:Text("*性别",style: TextStyle(fontSize: 12))
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:EdgeInsets.only(left: 10.0) ,
            width: 30,
            height: 40.0,
            child: Radio(
              value:"1",
              groupValue: _sex,
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
            child: Text("男",style: TextStyle(fontSize: 12)),
          ),
          Container(
//            color: Colors.red,
            padding:EdgeInsets.only(left: 10.0) ,
            alignment: Alignment.centerLeft,
            width: 30,
            height: 40.0,
            child: Radio(
              value:"0",
              groupValue: _sex,
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
            child: Text("女",style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
