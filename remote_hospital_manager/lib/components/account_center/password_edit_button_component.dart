import 'package:flutter/material.dart';
class PasswordEditButtonComponent extends StatelessWidget {
  @required final callback;
  PasswordEditButtonComponent({this.callback});
  _onPressed(){
    callback();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        color:Theme.of(context).accentColor,
        colorBrightness: Brightness.dark,
        textColor: Colors.white,
        child: Text("保存"),
        onPressed: (){
          _onPressed();
        },
      ),
    );
  }
}