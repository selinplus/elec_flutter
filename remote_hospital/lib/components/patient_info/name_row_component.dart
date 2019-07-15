import 'package:flutter/material.dart';
class NameRowComponent extends StatelessWidget {
  @required TextEditingController controller;// = TextEditingController();
  NameRowComponent({this.controller});
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
              child:Text("*姓名",style: TextStyle(fontSize: 12))
          ),
          Expanded(
            child: Container(
              height: 40.0,
//              color: Colors.red,
              padding:EdgeInsets.only(left: 10.0) ,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 12),
                cursorColor: Colors.black,
                cursorWidth: 0.5,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入姓名",
                    hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
