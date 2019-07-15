import 'package:flutter/material.dart';
class LabelNumberRowComponent extends StatelessWidget {
  final String label;
  final num value;
  final String unit;
  final increment;
  final reduce;
  LabelNumberRowComponent({this.label,this.value,this.unit,this.increment,this.reduce});
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
                child:Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove,color: Theme.of(context).accentColor,),
                        onPressed: (){
                          reduce();
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        alignment: Alignment.center,
                        child: Text("${value.toString()}$unit",style: TextStyle(fontSize: 12),),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,color: Theme.of(context).accentColor,),
                        onPressed: (){
                          increment();
                        },
                      ),
                    ],
                  ),
                )
            ),
          ],
        )
    );
  }
}


