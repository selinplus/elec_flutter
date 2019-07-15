import 'package:flutter/material.dart';
import '../components/account_center/account_center_component.dart';
import 'package:remote_hospital/models/yaodian.dart';
import 'package:remote_hospital/models/mendian.dart';
//import 'package:remote_hospital/services/pref_util.dart';
class AccountCenterPage extends StatelessWidget {
  Mendian mendian;
  AccountCenterPage({this.mendian});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("用户中心",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: AccountCenterComponent(mendian:mendian,)
    );
  }
}

