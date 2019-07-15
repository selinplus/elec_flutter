import 'package:flutter/material.dart';
import 'package:remote_hospital/components/zqdj/zqdj_component.dart';
import './patient_info_page.dart';
class ZqdjPage extends StatelessWidget {
  _enterYhxx(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return PatientInfoPage(null);
    },));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("诊前登记",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
             GestureDetector(
                   onTap: (){
                    _enterYhxx(context);
                   },
                   child: Container(
                     padding: EdgeInsets.only(right: 10.0),
                     height: 40,
                     alignment: Alignment.center,
                     child:Text("新增用户"),
                   )
               ),
            ],
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: ZqdjComponent(),
    );
  }
}
