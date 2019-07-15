import 'package:flutter/material.dart';
import 'package:remote_hospital/config.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/models/patient.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/models/doctor.dart';
import 'package:remote_hospital/components/md_prescription/md_prescription_component.dart';
import 'package:remote_hospital/models/prescription.dart';
class MdPrescriptionPage extends StatelessWidget {
  Doctor doctor;
  Mendian mendian;
  Prescription prescription;
  Patient patient;
  List<Medicine> preMedicine;
  MdPrescriptionPage({this.mendian,this.prescription,this.patient,this.doctor,this.preMedicine});
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
          child: MdPrescriptionComponent(mendian:mendian,prescription: prescription,patient: patient,doctor: doctor, preMedicine: preMedicine,)
          ),
        );
  }
}
