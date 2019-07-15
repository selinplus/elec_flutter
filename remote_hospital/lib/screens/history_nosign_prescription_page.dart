import 'package:flutter/material.dart';
import 'package:remote_hospital/models/patient.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/models/prescription.dart';
import 'package:remote_hospital/models/doctor.dart';
import 'package:remote_hospital/components/history_prescription/history_nosign_prescription_component.dart';
class HistoryNosignPrescriptionPage extends StatelessWidget {
  Patient patient;
  Prescription prescription;
  List<Medicine> preMedicines;
  Doctor doctor;
  HistoryNosignPrescriptionPage({this.patient,this.prescription,this.preMedicines,this.doctor});
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
        body:HistoryNosignPrescriptionComponent(patient:patient,prescription:prescription,preMedicines: preMedicines,doctor:doctor)

    );
  }
}