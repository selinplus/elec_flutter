import 'package:flutter/material.dart';
import 'package:remote_hospital/config.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/components/md_prescription/md_pres_list_component.dart';
class MdPresPage extends StatelessWidget {
//  Mendian mendian;
//  MdPresPage({this.mendian});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("待发放处方列表",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: Center(
          child: MdPresListComponent()
      ),
    );
  }
}
