import 'package:flutter/material.dart';
import '../components/doctor_info/select_doctor_component.dart';
import '../components/doctor_info/doctor_component.dart';
class DoctorPage extends StatelessWidget {
 // DoctorPage({this.presID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("选择医师",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: SelectDoctorComponent(),
    );
  }
}
