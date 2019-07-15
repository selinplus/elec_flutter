import 'package:flutter/material.dart';
import 'package:remote_hospital/components/prescription/ill_description_row.dart';
import 'package:remote_hospital/components/prescription/medicine_operation_row.dart';
import 'package:remote_hospital/components/prescription/presMedicine_row_component.dart';
import 'package:remote_hospital/screens/medicine_page.dart';
import '../../models/medicine.dart';
class PresComponent extends StatefulWidget {
  @override
  _PresComponentState createState() => _PresComponentState();
}

class _PresComponentState extends State<PresComponent> {
  TextEditingController bqmsController = TextEditingController();
  List<Medicine> presMedicine =List<Medicine>();
  _enterMedicine(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return MedicinePage();
    },)).then((val){
       setState(() {
         presMedicine.add(val);
       });
    });
  }
  removePresMedicine(val){
    setState(() {
      presMedicine.remove(val);
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        IllDesRow(
          label: "病情描述",
          controller:bqmsController,
          hintText: "请输入详细疾病描述2-100字",
        ),
        Divider(height: 1.0,),
        MedOperRow(callback: this._enterMedicine,),
        Divider(height: 1.0,),
        Container(
         child:presMedicine.length>0 ? Container(
             height: 30,
             padding: EdgeInsets.only(left: 10.0),
             child: Text("Rp", style: TextStyle(fontSize: 12,color:Colors.grey),),
         ):null
        ),
         ListView.builder(
            shrinkWrap:true,
            itemCount: presMedicine.length,
            itemExtent: 20,
            itemBuilder: (BuildContext context,int index){
              return PresMedicineRowComponent(index:index+1,medicine: presMedicine[index],callback: (val)=>removePresMedicine(val));
            },
          ),
      ],
    );
  }
}
