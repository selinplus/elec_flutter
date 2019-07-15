import 'package:flutter/material.dart';
class ButtonRowComponent extends StatelessWidget {
  @required final label;
  @required final callback;
  @required final bool isEnabled;
  ButtonRowComponent({this.label,this.callback,this.isEnabled});
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
        child: Text("$label"),
        onPressed:isEnabled?(){
          _onPressed();
        }:null,
      ),
    );
  }
}