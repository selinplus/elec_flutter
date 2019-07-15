import 'package:flutter/material.dart';
class RegisterButtonComponent extends StatelessWidget {
  @required final callback;
  RegisterButtonComponent({this.callback});
  _onPressed(){
    callback();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: RaisedButton(
        color:Theme.of(context).accentColor,
        colorBrightness: Brightness.dark,
        textColor: Colors.white,
        child: Text("注册"),
        onPressed: (){
          _onPressed();
        },
      ),
    );
  }
}