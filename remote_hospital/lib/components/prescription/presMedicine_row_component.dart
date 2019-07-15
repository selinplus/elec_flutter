import 'package:flutter/material.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/components/prescription/medicine_num_row_component.dart';
class PresMedicineRowComponent extends StatelessWidget {
  int index;
  Medicine medicine;
  final callback,increment,reduce;
  final bool canOper;

  PresMedicineRowComponent({this.index,this.medicine,this.callback,this.increment,this.reduce,this.canOper});

  _increment(){
    //print((index+1).toString());
    increment(index-1);
  }
  _reduce(){
    reduce(index-1);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text("${index.toString()}"+"、", style: TextStyle(fontSize: 12,color:Colors.grey),),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text("${medicine.mc}", style: TextStyle(fontSize: 12,color:Colors.grey),),
            ),
          ),
          Container(
            child: Container(
              child: Text("${medicine.style}", style: TextStyle(fontSize: 12,color:Colors.grey),),
            ),
          ),
          Container(
             child:MedicineNumberRowComponent(num:medicine.cnt,unit: medicine.unit,increment:_increment,reduce:_reduce,canOper: canOper,) ,
          ),
          Container(
              //color:Colors.blue,
              margin: EdgeInsets.only(left: 15.0,right: 5.0),
             // padding:  EdgeInsets.symmetric(vertical: 10.0),
//              width: 40,
              //height: 60,
              alignment: Alignment.center,
              child: canOper?IconButton(
                  padding:EdgeInsets.symmetric(horizontal: 0.0),
                  icon:Icon(
                      Icons.remove,
                      color:Colors.red,
                      size:30,
                  ),
                  onPressed: (){
                      callback(this.medicine);
                  }
              ):null
          )
        ],
      ),
    );
  }
}
