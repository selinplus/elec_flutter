import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/doctor/doctor_noreview_list_component.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
class DoctorNoreviewListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("待审核医师列表",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: DoctorNoreviewListComponent()
    );
  }
}
