import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../screens/login_page.dart';
import 'package:remote_hospital/services/pref_util.dart';
class ExitButtonComponent extends StatelessWidget {

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        color:Theme.of(context).accentColor,
        colorBrightness: Brightness.dark,
        textColor: Colors.white,
        child: Text("退出系统"),
        onPressed: () async{
          await pop();
//          removePref("password")
//              .then((_)=>removePref("token"))
//              .then((_){
//               Navigator.pushNamedAndRemoveUntil(context,'/login', (Route<dynamic> route) => false);
//          });
        },
      ),
    );
  }
}