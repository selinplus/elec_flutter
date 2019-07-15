import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SfzhRowComponent extends StatelessWidget {
  @required TextEditingController controller;
  SfzhRowComponent({this.controller});
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
                child:Text("身份证号",style: TextStyle(fontSize: 12))
            ),
            Expanded(
//           color: Colors.blue,
//           width: 90.0,
//           height: 40.0,
                child: Container(
//             color: Colors.blue,
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  height: 40.0,
                  child: TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    keyboardType:TextInputType.text,
                    inputFormatters:[WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入身份证号",
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                    ),
                  ),
                )//
            )
          ],
        )
    );
  }
}
