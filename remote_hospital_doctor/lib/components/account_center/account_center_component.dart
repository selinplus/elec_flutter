import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:remote_hospital_doctor/components/account_center/account_row_component.dart';
import 'package:remote_hospital_doctor/components/account_center/exit_button_component.dart';
import 'package:remote_hospital_doctor/components/account_center/account_identified_component.dart';
import 'package:remote_hospital_doctor/components/account_center/account_login_component.dart';
import 'package:remote_hospital_doctor/components/account_center/account_sign_component.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/config.dart';
import 'package:remote_hospital_doctor/components/account_center/account_update_component.dart';

class AccountCenterComponent extends StatefulWidget {
  Doctor doctor;
  AccountCenterComponent({this.doctor});
  @override
  _AccountCenterComponentState createState() => _AccountCenterComponentState();
}

class _AccountCenterComponentState extends State<AccountCenterComponent> {
   Doctor doctor;

   @override
   void initState(){
     super.initState();
     doctor=widget.doctor;
   }
  _onPasswordChanged(val){
    doctor.password=val;
    print(doctor.password);
    Map<String,dynamic> params =Map<String,dynamic>();
    params["id"]=doctor.ID;
    params["password"]=doctor.password;
    DioUtil().postWithJson(true, "/api/v1/yishi/upd/pwd",data:params,
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
    params["id"]=doctor.ID;
    params["qz_uri"]=val;
    DioUtil().postWithJson(true, "/api/v1/yishi/updyishiqz",data:params,
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
        setPrefString("qz_uri", val).then((_){
          Fluttertoast.showToast(
              msg: "签字保存成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
          setState(() {
            doctor.qz_uri=val;
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
        AccountRowComponent(label: "服务药店",value:"${doctor.yaodian_mc}"),
        Divider(height: 1,),
        AccountRowComponent(label: "医师姓名",value:"${doctor.name}"),
        Divider(height: 1,),
        AccountRowComponent(label: "执业单位",value: "${doctor.zydw}"),
        Divider(height: 1,),
        AccountRowComponent(label: "所在科室",value: "${doctor.dept}"),
        Divider(height: 1,),
        AccountRowComponent(label: "医师执业证号",value: "${doctor.zyzbm}"),
        Divider(height: 1,),
        AccountRowComponent(label: "医师资格证号",value: "${doctor.zgzbm}"),
        Divider(height: 1,),
        AccountRowComponent(label: "身份证号",value: "${doctor.sfzh}"),
        Divider(height: 1,),
        AccountRowComponent(label: "简介",value: "${doctor.jianjie}"),
        Divider(height: 1,),
        AccountRowComponent(label: "手机号码",value: "${doctor.mobile}"),
        Divider(height: 1,),
        AccountRowComponent(label: "当前状态",value: "${doctor.zhuangtai}"),
        Divider(height: 1,),
        AccountRowComponent(label: "审核状态",value: doctor.review?"审核通过":"未审核"),
        Divider(height: 1,),
        AccountSignComponent(label: "维护签名",yisqzuri: doctor.qz_uri,callback: (val)=>onSign(val),review: doctor.review,),
        Divider(height: 1,),
        AccountIdentifiedComponent(doctor: doctor,),
        Divider(height: 1,),
        AccountLoginComponent(label: "登录账户",value:doctor.username, callback:(val)=>_onPasswordChanged(val) ,),
        Divider(height: 1,),
        AccountRowComponent(label: "当前版本",value: Config.VERSION),
        Divider(height: 1,),
        AccountUpdateComponent(label: "系统更新",),
        Divider(height: 1,),
        ExitButtonComponent()
      ],
    );
  }
}
