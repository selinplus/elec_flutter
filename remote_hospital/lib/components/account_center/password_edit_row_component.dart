import 'package:flutter/material.dart';
class PasswordEditRowComponent extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  PasswordEditRowComponent({this.label,this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
//           color: Colors.red,
                width: 150.0,
                height: 40.0,
                child:Text("$label",style: TextStyle(fontSize: 12))
            ),
            Expanded(
                child: Container(
//             color: Colors.blue,
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  height: 40.0,
                  child: TextField(
                    obscureText: true,
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )//
            ),
          ],
        )
    );
  }
}
