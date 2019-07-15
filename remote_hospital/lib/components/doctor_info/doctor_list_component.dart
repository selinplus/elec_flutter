import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import 'package:remote_hospital/components/doctor_info/doctor_component.dart';
class DoctorListComponent extends StatelessWidget {
  @required List<Doctor> doctorList=List<Doctor>();
  @required final callback;
  DoctorListComponent({this.doctorList,this.callback});
   Future<void> _onRefresh() async {
      await callback();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: doctorList.length,
        itemBuilder: (BuildContext context,int index){
          return DoctorComponent(doctor:doctorList[index]);
        },
        separatorBuilder: (BuildContext context,int index){
          return Container(
              height: 5,
              color:Colors.grey[100]
          );
        },
      ),
      onRefresh: _onRefresh,
    );
  }
}
