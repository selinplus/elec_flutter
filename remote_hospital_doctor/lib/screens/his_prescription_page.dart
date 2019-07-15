import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/history_prescription/his_prescription_component.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
import 'package:remote_hospital_doctor/models/medicine.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
class HisPrescriptionPage extends StatelessWidget {
  Prescription prescription;
  Patient patient;
  Doctor doctor;
  List<Medicine> preMedicine;
  HisPrescriptionPage({this.prescription,this.patient,this.doctor,this.preMedicine});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("处方信息",style: TextStyle(fontSize: 18,color: Colors.white)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: HisPrescriptionComponent(prescription:prescription,patient:patient,doctor:doctor,preMedicine:preMedicine)
    );
  }
}
