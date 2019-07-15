import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/identified/identified_component.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
class IdentifiedPage extends StatelessWidget {
  Doctor doctor;
  IdentifiedPage({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("身份认证（不可修改）",style: TextStyle(fontSize: 18,color: Colors.white)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: IdentifiedComponent(doctor: doctor,)
    );
  }
}
