import 'package:flutter/material.dart';
class IllDesRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isDisplayOnly;
  IllDesRow({this.label,this.controller,this.hintText,this.isDisplayOnly});
  @override
  Widget build(BuildContext context) {
    return Container(
       //height:60 ,
        child:Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
//           color: Colors.red,
                width: 90.0,
               // height: 40.0,
                child:Text("$label",style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor))
            ),
            Expanded(
                child: Container(
                  //color: Colors.blue,
                  margin: EdgeInsets.only(left: 10.0,right: 10.0),
                  alignment: Alignment.centerLeft,
                 // height: 40.0,
                  width: 200,
                  child: TextField(
                    enabled:!isDisplayOnly ,
                    controller: controller,
                    maxLength: isDisplayOnly? TextField.noMaxLength:12,
                    maxLines: null,
                    style: TextStyle(fontSize: 12,color:isDisplayOnly?Colors.grey:Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "$hintText",
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                    ),
                  ),
                )//
            ),
          ],
        )
    );
  }
}


