import 'package:flutter/material.dart';
import '../components/doctor_info/select_doctor_component.dart';
import '../components/doctor_info/doctor_component.dart';
import 'package:remote_hospital/components/doctor_info/doctor_detail_component.dart';
import 'package:remote_hospital/models/doctor.dart';
class DoctorDetailPage extends StatelessWidget {
  Doctor doctor;
  DoctorDetailPage({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("医师详细信息",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: DoctorDetailComponent(doctor: this.doctor,havaSendedToDoctor: true,isDisplaySendToDoctor: false,),
    );
  }
}
