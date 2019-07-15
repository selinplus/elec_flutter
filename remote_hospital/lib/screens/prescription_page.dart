import 'package:flutter/material.dart';
import 'package:remote_hospital/models/patient.dart';
import 'package:remote_hospital/components/prescription/prescription_component.dart';
class PresPage extends StatelessWidget {
  Patient patient;
  PresPage({this.patient});
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
              actions: <Widget>[
                GestureDetector(
                    onTap: (){
                      Navigator.popUntil(context,ModalRoute.withName('/main'));
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10.0),
                      height: 40,
                      alignment: Alignment.center,
                      child:Text("返回诊前登记"),
                    )
                ),
              ],
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body:PresComponent(patient: patient,)
    );
  }
}