import 'package:flutter/material.dart';
import './account_row_component.dart';
import './account_login_component.dart';
import './exit_button_component.dart';
import '../../models/yaodian.dart';
import '../../models/mendian.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/services/pref_util.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:remote_hospital/config.dart';
import './account_sign_component.dart';
import './account_update_component.dart';

class AccountCenterComponent extends StatefulWidget {
  Mendian mendian;
  AccountCenterComponent({this.mendian});
  @override
  _AccountCenterComponentState createState() => _AccountCenterComponentState();
}

class _AccountCenterComponentState extends State<AccountCenterComponent> {

  Mendian mendian;
  void initState(){
    mendian=widget.mendian;
  }
 _onPasswordChanged(val){
    mendian.password=val;
    print(mendian.password);

    Map<String,dynamic> params =Map<String,dynamic>();
    params["id"]=mendian.ID;
    params["password"]=mendian.password;
    DioUtil().postWithJson(true, "/api/v1/mendians/eidtpass",data:params,
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

  onSign(val){
    Map<String,dynamic> params = Map<String,dynamic>();
    params["id"]=mendian.ID;
    params["yaosshuri"]=val;
    DioUtil().postWithJson(true, "/api/v1/mendian/edityaosshqzuri",data:params,
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
        setPrefString("yaosshuri", val).then((_){
          Fluttertoast.showToast(
              msg: "签字保存成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
          setState(() {
            mendian.yaosshuri=val;
          });
        });
      }else {
        Fluttertoast.showToast(
            msg: "签字保存失败,${data['code']}: ${data['msg']}",
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
        AccountRowComponent(label: "药店名称",value:mendian.yaodian_mc),
        Divider(height: 1,),
        AccountRowComponent(label: "门店注册码",value: mendian.licence),
        Divider(height: 1,),
        AccountRowComponent(label: "门店名称",value: mendian.mc),
        Divider(height: 1,),
        AccountRowComponent(label: "门店负责人",value: mendian.fzr),
        Divider(height: 1,),
        AccountRowComponent(label: "电话",value: mendian.dianhua),
        Divider(height: 1,),
//        AccountSignComponent(label: "维护审核药师签字",yaosqzuri: mendian.yaosshuri,callback: (val)=>onSign(val)),
//        Divider(height: 1,),
        AccountLoginComponent(label: "登录账户",md: mendian,callback:(val)=>_onPasswordChanged(val) ,),
        Divider(height: 1,),
        AccountRowComponent(label: "当前版本",value:Config.VERSION),
        Divider(height: 1,),
        AccountUpdateComponent(label: "系统更新",),
        Divider(height: 1,),
        ExitButtonComponent()
      ],
    );
  }
}
