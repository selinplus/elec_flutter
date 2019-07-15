import 'package:flutter/material.dart';
import '../components/login/login_component.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: PreferredSize(
//            child: AppBar(
//              title: Text("登录",style: TextStyle(fontSize: 18)),
//              //toolbarOpacity: 0.6,
//              backgroundColor: Theme.of(context).accentColor,
//              centerTitle: true,
//              elevation: 0.0,
//            ),
//            preferredSize:Size.fromHeight(40)
//        ),
        body: LoginComponent()
    );
  }
}

