import 'package:flutter/material.dart';
class YwgmsRowComponent extends StatelessWidget {
  final String _ywgms;
  final callback;
  YwgmsRowComponent(this._ywgms,{this.callback});
  onChange(val){
    callback(val);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10.0),
              alignment: Alignment.centerLeft,
              width: 90.0,
              height: 40.0,
              child: Text("药物过敏史",style: TextStyle(fontSize: 12))
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding:EdgeInsets.only(left: 10.0) ,
            width: 30,
            height: 40.0,
            child: Radio(
              value: "0",
              groupValue: _ywgms,
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
            child: Text("无",style: TextStyle(fontSize: 12)),
          ),
          Container(
            padding:EdgeInsets.only(left: 10.0) ,
            alignment: Alignment.centerLeft,
            width: 30,
            height: 40.0,
            child: Radio(
              value: "1",
              groupValue: _ywgms,
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
            child: Text("有",style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
