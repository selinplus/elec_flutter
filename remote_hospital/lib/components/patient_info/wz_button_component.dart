import 'package:flutter/material.dart';
class WzButton extends StatelessWidget {
  @required final callback;
  WzButton({this.callback});
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
      child: Text("快速问诊"),
      onPressed: (){
        _onPressed();
      },
    ),
  );
}
}