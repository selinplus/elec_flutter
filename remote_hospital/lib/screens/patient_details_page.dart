import 'package:flutter/material.dart';
import '../components/patient_info/patient_details_component.dart';
import '../models/patient.dart';
class PatientDetailsPage extends StatelessWidget {
  Patient patient;
  PatientDetailsPage({this.patient});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("病人详细信息",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body:PatientDetailsComponent(patient:patient)
    );
  }
}


