import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/config.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/components/prescription/pres_list_component.dart';
class PresPage extends StatelessWidget {
//  Doctor doctor;
//  PresPage({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("待开处方列表",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: Center(
          child: PresListComponent()
      ),
    );
  }
}
