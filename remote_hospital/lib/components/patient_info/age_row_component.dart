import 'package:flutter/material.dart';
class AgeRowComponent extends StatelessWidget {
  final TextEditingController controller;
  AgeRowComponent({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
//           color: Colors.red,
                width: 90.0,
                height: 40.0,
                child:Text("年龄",style: TextStyle(fontSize: 12))
            ),
            Expanded(
                child: Container(
//             color: Colors.blue,
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  height: 40.0,
                  child: TextField(
                    enabled:false,
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                  ),
                )//
            ),
          ],
        )
    );
  }
}
