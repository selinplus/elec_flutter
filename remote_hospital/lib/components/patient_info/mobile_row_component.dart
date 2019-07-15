import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MobileRowComponent extends StatelessWidget {
  @required TextEditingController controller;
  MobileRowComponent({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                width: 90.0,
                height: 40.0,
                child:Text("*手机号码",style: TextStyle(fontSize: 12))
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  height: 40.0,
                  child: TextField(
                    keyboardType:TextInputType.phone,
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入手机号码",
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
