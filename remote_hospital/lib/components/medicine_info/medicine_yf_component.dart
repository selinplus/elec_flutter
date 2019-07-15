import 'package:flutter/material.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/components/common/label_text_row_component.dart';
import 'package:remote_hospital/components/common/label_number_row_component.dart';
import 'package:remote_hospital/components/common/button_row_component.dart';

class MedicineYfComponent extends StatefulWidget {
  @required final Medicine medicine;
  MedicineYfComponent({this.medicine});
  @override
  _MedicineYfComponentState createState() => _MedicineYfComponentState();
}

class _MedicineYfComponentState extends State<MedicineYfComponent> {
  int num;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    num=1;
  }
  void increment(){
    setState(() {
      num++;
    });
  }
 void reduce(){
    if(num>1){
      setState(() {
        num--;
      });
    }
  }
backtoPrescription(BuildContext context){
  Navigator.pop(context,num);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          LabelTextRowComponent(label: "药品名称",value: widget.medicine.mc+"("+widget.medicine.style+")",),
          Divider(height: 1.0,),
          LabelNumberRowComponent(label: "数量",value: num,increment: increment,reduce:reduce),
          Divider(height: 1.0,),
          ButtonRowComponent(label: "确定",callback: ()=>backtoPrescription(context),),

        ],
      ),
    );
  }
}
