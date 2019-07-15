import 'package:flutter/material.dart';
import '../../models/medicine.dart';
import 'package:remote_hospital/components/medicine_info/medicine_component.dart';
class MedicineListComponent extends StatelessWidget {
  @required List<Medicine> medicineList=List<Medicine>();
  MedicineListComponent({this.medicineList});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: medicineList.length,
      itemBuilder: (BuildContext context,int index){
        return MedicineComponent(medicine:medicineList[index]);
      },
      separatorBuilder: (BuildContext context,int index){
        return Container(
            height: 1,
            color:Colors.grey[100]
        );
      },
    );
  }
}
