import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/config.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
import 'package:remote_hospital_doctor/models/medicine.dart';
import 'package:remote_hospital_doctor/components/prescription/prescription_component.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
class PrescriptionPage extends StatelessWidget {
  Doctor doctor;
  Prescription prescription;
  Patient patient;
  List<Medicine> preMedicine;
  PrescriptionPage({this.doctor,this.prescription,this.patient,this.preMedicine});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("处方信息",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: Center(
          child: PrescriptionComponent(doctor:doctor,prescription: prescription,patient: patient,preMedicine: preMedicine,)
          ),
        );
  }
}
