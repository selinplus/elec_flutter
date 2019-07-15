import 'package:flutter/material.dart';
import '../components/login/login_component.dart';
import '../components/register/register_component.dart';
import 'package:remote_hospital/models/yaodian.dart';
class RegisterPage extends StatelessWidget {
  Yaodian yaodian;
  RegisterPage({this.yaodian});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("门店注册",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: RegisterComponent(yaodian: yaodian,)
    );
  }
}

