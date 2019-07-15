import 'package:flutter/material.dart';
class MedOperRow extends StatelessWidget {
  final bool canPer;
  final callback;

  MedOperRow({this.callback,this.canPer});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 40,
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                textColor: Theme
                    .of(context)
                    .accentColor,
                child: Text("添加处方药", style: TextStyle(fontSize: 12)),
                color: Colors.white,
                shape: Border.all(
                    color: Theme
                        .of(context)
                        .accentColor,
                    width: 1.0,
                    style: BorderStyle.solid
                ),
                onPressed: canPer?() {
                  this.callback();
                }:null,
              ),
            ),
          ]
      ),
    );
  }
}
