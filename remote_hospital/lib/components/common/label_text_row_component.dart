import 'package:flutter/material.dart';
class LabelTextRowComponent extends StatelessWidget {
  final String label;
  final String value;
  LabelTextRowComponent({this.label,this.value});
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
                height: 60.0,
                child:Text("$label",style: TextStyle(fontSize: 12))
            ),
            Expanded(
                child: Container(
//             color: Colors.blue,
                  padding: EdgeInsets.only(left: 10.0,right:30.0),
                  alignment: Alignment.centerLeft,
                  height: 60.0,
                  child: Text("$value", style: TextStyle(fontSize: 12,color:Colors.grey), ),
                )//
            ),
          ],
        )
    );
  }
}


