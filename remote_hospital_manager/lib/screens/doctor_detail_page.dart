import 'package:flutter/material.dart';
import 'package:remote_hospital_manager/components/doctor/doctor_detail_info.dart';
import 'package:remote_hospital_manager/models/doctor.dart';
class DoctorDetailPage extends StatelessWidget {
  Doctor doctor;
  DoctorDetailPage({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("医师详情",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: DoctorDetailInfo(doctor: doctor,)
    );
  }
}
