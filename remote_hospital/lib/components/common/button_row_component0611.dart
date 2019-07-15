import 'package:flutter/material.dart';
class ButtonRowComponent extends StatelessWidget {
  final callback;
  final String label;
  ButtonRowComponent({this.label,this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 40,
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                textColor: Theme
                    .of(context)
                    .accentColor,
                child: Text("$label", style: TextStyle(fontSize: 10)),
                color: Colors.white,
                shape: Border.all(
                    color: Theme
                        .of(context)
                        .accentColor,
                    width: 1.0,
                    style: BorderStyle.solid
                ),
                onPressed: () {
                  this.callback();
                },
              ),
            ),
          ]
      ),
    );
  }
}
