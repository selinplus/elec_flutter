import 'package:flutter/material.dart';
import 'package:remote_hospital/screens/prescription_page.dart';
import 'package:remote_hospital/services/pref_util.dart';
import 'package:remote_hospital/services/dio_util.dart';
import './ts_row_component.dart';
import './mobile_row_component.dart';
import './name_row_component.dart';
import './sex_row_component.dart';
import './married_row_component.dart';
import './sfzh_row_component.dart';
import './birthday_row_component.dart';
import './age_row_component.dart';
import './weight_row_component.dart';
import './ywgms_row_component.dart';
import './address_row_commponent.dart';
import './wz_button_component.dart';
import './zlxz_row_component.dart';
import '../../models/patient.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PatientInfoComponent extends StatefulWidget {
  Patient _patient;
  PatientInfoComponent(this._patient);
  @override
  _PatientInfoComponentState createState() => _PatientInfoComponentState();
}

class _PatientInfoComponentState extends State<PatientInfoComponent> {
  Patient patient;
  String zlxz;
  bool isChanged=false;
  bool isNew=true;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sfzhController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  _onSexChange(val){
    if(patient.sex!=val){
      isChanged=true;
      print("patient.sex changed");
    }
    setState(() {
      patient.sex=val;
    });
  }
  _onZlxzChange(val){
    setState(() {
      zlxz=val;
    });
  }
  _onMarriedChange(val){
    if(patient.married!=val){
      isChanged=true;
      print("patient.married changed");
    }
    setState(() {
      patient.married=val;
    });
  }
  _onYwgmsChange(val){
    if(patient.ywgms!=val){
      isChanged=true;
      print("patient.ywgms changed");
    }
    setState(() {
      patient.ywgms=val;
    });
  }
  _onBirthDayChange(val){
//    var formatter = DateFormat('yyyy-MM-dd');
//    setState(() {
//      _birthdayController.text=formatter.format(val).toString();
//      _ageController.text=_getAge(val);
//      print("patient.birthday changed");
//    });
  if(val.length<4){
    _ageController.text="";
  }else{
    int age =DateTime.now().year-int.parse(val);
    if (age<0){
      Fluttertoast.showToast(
          msg: "出生年份不正确",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    _ageController.text=age.toString();
  }
  }
 String _getAge(DateTime val){
    int years;
    var dt= DateTime.now();
    if(dt.isAfter(val)) {
      years = dt.year - val.year;
      int months = dt.month - val.month;
      print(years);
      print(months);
      if (months < 0) {
        years = years - 1;
        setState(() {
          _ageController.text=years.toString();
        });
      } else if(months==0){
        int days = dt.day - val.day;
        print(days);
        if (days < 0) {
          years = years - 1;
        }
      }
    }else{
      years=0;
    }
    return years.toString();
  }
  _quickWz(){
    if(zlxz==null){
      Fluttertoast.showToast(
          msg: '请选择诊疗类型',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(zlxz!="1"){
      Fluttertoast.showToast(
          msg: '不能为初诊病人问诊',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.green,
          textColor: Colors.white
      );
      return;
    }
    if(_mobileController.text.length==0){
      Fluttertoast.showToast(
          msg: '请输入手机号',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(_mobileController.text.length!=11){
      Fluttertoast.showToast(
          msg: '请输入正确的手机号',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(_nameController.text.length==0){
      Fluttertoast.showToast(
          msg: '请输入姓名',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(patient.sex==""||patient.sex == null) {
      Fluttertoast.showToast(
          msg: '请选择性别',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
      return;
    }

    if(patient.married==""||patient.married == null){
      Fluttertoast.showToast(
          msg: '请选择婚否',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(_birthdayController.text.length<4){
      Fluttertoast.showToast(
          msg: '请填写4位数出生年份',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    if(int.parse(_ageController.text)<16){
      Fluttertoast.showToast(
          msg: '小于16岁的儿童需填写体重',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }

    if(patient.mobile!=_mobileController.text){
      isChanged=true;
      print("patient.mobile changed");
    }
    if(patient.name!=_nameController.text){
      isChanged=true;
      print("patient.name changed");
    }
    if(patient.sfzh!=_sfzhController.text){
      isChanged=true;
      print("patient.sfzh changed");

    }
    if(patient.birthday!=_birthdayController.text){
      isChanged=true;
      print("patient.birthday changed");
    }
    if(patient.weight!=_weightController.text){
      isChanged=true;
      print("patient.weight changed");
    }
    if(patient.address!=_addressController.text){
      isChanged=true;
      print("patient.address changed");
    }
    if(patient.age!=int.parse(_ageController.text)){
      isChanged=true;
      print("patient.age changed");
    }
    patient.mobile = _mobileController.text;
    patient.name = _nameController.text;
    patient.sfzh = _sfzhController.text;
    patient.birthday = _birthdayController.text;
    patient.weight = _weightController.text;
    patient.address = _addressController.text;
    patient.age = int.parse(_ageController.text);
    getPrefInt("mdid").then((val){
      patient.mendian_id=val;
      if(isNew){
        print("New");
        DioUtil().post(true, "/api/v1/patients",data: patient.toJson(),
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
        ).then((data) {
          print('http response: ${data["code"]}');
          if(data["code"]==200) {
            patient.ID=data["data"];
            print(patient.ID.toString());
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //指定跳转的页面
              return PresPage(patient: patient,);
            },));
          }else{
            Fluttertoast.showToast(
                msg: "保存用户信息失败,${data['code']}: ${data['msg']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          }
        });
      }else if(isChanged){
        print("Changed");
        DioUtil().post(true, "/api/v1/patients/"+patient.ID.toString(),data: patient.toJson(),
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
        ).then((data) {
          print('http response: ${data["code"]}');
          if(data["code"]==200) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //指定跳转的页面
              return PresPage(patient: patient,);
            },));
          }else{
            Fluttertoast.showToast(
                msg: "更改用户信息失败,${data['code']}: ${data['msg']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          }
        });
      }else{
        print("No Changed");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          //指定跳转的页面
          return PresPage(patient: patient,);
        },));
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    if(widget._patient==null){
      patient= Patient.name();
      isNew=true;
    }else{
      patient=widget._patient;
      isNew=false;
    }
    _mobileController.text=patient.mobile;
    _nameController.text=patient.name;
    _sfzhController.text=patient.sfzh;
    _birthdayController.text=patient.birthday;
//    _ageController.text=_birthdayController.text==""?"":_getAge(DateTime.parse(_birthdayController.text));//patient.age;
    _ageController.text=_birthdayController.text==""?"":(DateTime.now().year - int.parse(_birthdayController.text)).toString();
    _weightController.text=patient.weight;
    _addressController.text=patient.address;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TsRowComponent(),
        Divider(height: 1.0, ),
        ZlxzRowComponent(zlxz:zlxz,callback:(val)=> _onZlxzChange(val),),
        Divider(height: 1.0, ),
        MobileRowComponent(controller: _mobileController),
        Divider(height: 1.0, ),
        NameRowComponent(controller: _nameController),
        Divider(height: 1.0, ),
        SexRowComponent(patient.sex,callback:(val)=>_onSexChange(val)),
        Divider(height: 1.0, ),
        MarriedRowComponent(patient.married,callback: (val)=>_onMarriedChange(val)),
        Divider(height: 1.0, ),
        SfzhRowComponent(controller: _sfzhController),
        Divider(height: 1.0, ),
        BirthdayRowComponent(controller: _birthdayController,callback: (val)=>_onBirthDayChange(val)),
        Divider(height: 1.0, ),
        AgeRowComponent(controller: _ageController,),
        Divider(height: 1.0, ),
        WeightRowComponent(controller: _weightController),
        Divider(height: 1.0, ),
        YwgmsRowComponent(patient.ywgms,callback: (val)=>_onYwgmsChange(val)),
        Divider(height: 1.0, ),
        AddressRowComponent(controller: _addressController),
        Divider(height: 1.0, ),
        WzButton(callback:_quickWz)
      ],
    );
  }
}


