import 'package:flutter/material.dart';
import 'package:remote_hospital/components/medicine_info/medicine_yf_component.dart';
import 'package:remote_hospital/models/medicine.dart';
class MedicineYfPage extends StatelessWidget {
  final Medicine medicine;
  MedicineYfPage({this.medicine});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("填写数量及用法",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: MedicineYfComponent(medicine: this.medicine,),
    );
  }
}
