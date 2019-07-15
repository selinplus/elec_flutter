import 'package:flutter/material.dart';
import '../components/patient_info/patient_info_component.dart';
import '../models/patient.dart';
class PatientInfoPage extends StatelessWidget {
  Patient _patient;
  PatientInfoPage(this._patient);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("录入用户信息",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body:PatientInfoComponent(_patient)
    );
  }
}


