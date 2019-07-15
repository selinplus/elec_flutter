import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class WeightRowComponent extends StatelessWidget {
  @required TextEditingController controller;
  WeightRowComponent({this.controller});
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
              child:Text("体重(kg)",style: TextStyle(fontSize: 12))
          ),
          Expanded(
            child: Container(
              height: 40.0,
              padding:EdgeInsets.only(left: 10.0) ,
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 12),
                cursorColor: Colors.black,
                cursorWidth: 0.5,
                inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9.]"))],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "小于16岁的儿童需填写体重",
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
