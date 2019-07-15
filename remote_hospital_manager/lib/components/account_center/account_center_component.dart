import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_manager/services/pref_util.dart';
import 'package:remote_hospital_manager/services/dio_util.dart';
import 'package:remote_hospital_manager/components/account_center/account_row_component.dart';
import 'package:remote_hospital_manager/components/account_center/account_login_component.dart';
//import 'package:remote_hospital_doctor/components/account_center/exit_button_component.dart';
import 'package:remote_hospital_manager/models/yaodian.dart';
import 'package:remote_hospital_manager/config.dart';
import 'package:remote_hospital_manager/components/account_center/account_update_component.dart';

class AccountCenterComponent extends StatefulWidget {
  Yaodian yaodian;
  AccountCenterComponent({this.yaodian});
  @override
  _AccountCenterComponentState createState() => _AccountCenterComponentState();
}

class _AccountCenterComponentState extends State<AccountCenterComponent> {
  Yaodian yaodian;
   @override
   void initState(){
     super.initState();
    yaodian =widget.yaodian;
   }
  _onPasswordChanged(val){
    yaodian.password=val;
    print(yaodian.password);
    Map<String,dynamic> params =Map<String,dynamic>();
    params["id"]=yaodian.ID;
    params["password"]=yaodian.password;
    DioUtil().postWithJson(true, "/api/v1/yaodians/eidtpass",data:params,
        errorCallback: (statuscode){
          print('http error code :$statuscode');
          Fluttertoast.showToast(
              msg: 'http error code :$statuscode',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
    ).then((data){
      if(data["code"]==200) {
        print(data);
        setPrefString("password", val).then((_){
          Fluttertoast.showToast(
              msg: "密码修改成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
        });
      }else {
        Fluttertoast.showToast(
            msg: "密码修改失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AccountRowComponent(label: "药店名称",value:"${yaodian.mc}"),
        Divider(height: 1,),
        AccountLoginComponent(label: "登录账户",value:"${yaodian.username}", callback:(val)=>_onPasswordChanged(val) ,),
        Divider(height: 1,),
        AccountRowComponent(label: "当前版本",value: Config.VERSION),
        Divider(height: 1,),
        AccountUpdateComponent(label: "系统更新",),
        Divider(height: 1,),
       // ExitButtonComponent()
      ],
    );
  }
}
