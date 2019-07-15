import 'package:flutter/material.dart';
class MedicineNumberRowComponent extends StatelessWidget {
  final int num;
  final String unit;
  final increment;
  final reduce;
  final bool canOper;
  MedicineNumberRowComponent({this.num,this.unit,this.increment,this.reduce,this.canOper});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left:10),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
           Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Container(
                        //color:Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        alignment: Alignment.center,
                        width: 20,
                        child: canOper?IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          icon: Icon(Icons.remove,color: Theme.of(context).accentColor,size: 20,),
                          onPressed: (){
                            reduce();
                          },
                        ):null,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        alignment: Alignment.center,
                        child: !canOper?Text("数量：",style: TextStyle(fontSize: 10,color: Colors.grey),):null,
                      ),
                      Container(
//                        width: 30,
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        alignment: Alignment.center,
                        child: Text(unit==null?"${num.toString()}":"${num.toString()}$unit",style: TextStyle(fontSize: canOper?12.0:10.0,color: canOper?Colors.black:Colors.grey),),
                      ),
                      Container(
                        //color:Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        alignment: Alignment.center,
                        width: canOper?20:0,
                        child: canOper?IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          icon: Icon(Icons.add,color: Theme.of(context).accentColor,size: 20,),
                          onPressed: (){
                            increment();
                          },
                        ):null,
                      ),
                    ],
                  ),
                )
          ],
        )
    );
  }
}


