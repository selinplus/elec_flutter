import 'package:flutter/material.dart';
import './register_row_component.dart';
import './register_button_component.dart';
import './register_jianjie_row_component.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'package:remote_hospital_doctor/models/yaodian.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/screens/login_page.dart';
class RegisterComponent extends StatefulWidget {
  Yaodian yaodian;
  final initWebsocket;
  RegisterComponent({this.yaodian,this.initWebsocket});
  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //Yaodian yaodian=Yaodian.name;
  Doctor doctor =Doctor.name();
  TextEditingController ydController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController zydwController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController zyzbmController = TextEditingController();
  TextEditingController zgzbmController = TextEditingController();
  TextEditingController sfzhController = TextEditingController();
  TextEditingController jianjieController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController againPwdController = TextEditingController();

   void onSubmit(){
     var _form = _formKey.currentState;
     if(_form.validate()){
       _form.save();
       doctor.review=false;
       print(doctor.toJson());
       DioUtil().postWithJson(false, "/yishi/reg",data: doctor.toJson(),
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
         if(data["code"]==200){
           Fluttertoast.showToast(
               msg: "注册成功,请登录",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIos: 1,
               backgroundColor:Colors.green,
               textColor: Colors.white
           );
           // Navigator.of(context).pushReplacementNamed("/login");
             print(data);
             setPrefString("username",doctor.username)
             .then((_) {
             //Navigator.of(context).pop();
             // Navigator.pushNamedAndRemoveUntil(context,'/login', (Route<dynamic> route) => false);
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                 //指定跳转的页面
                 return LoginPage(initWebsocket: widget.initWebsocket,);
               },), (Route<dynamic> route) => false);
           });

         }else{
           Fluttertoast.showToast(
               msg: "注测失败,${data['code']}: ${data['msg']}",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIos: 1,
               backgroundColor:Colors.red,
               textColor: Colors.white
           );
         }
       });
     }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ydController.text= widget.yaodian.mc;
    doctor.yaodian_id=widget.yaodian.ID;
  }

  String nameValidate(val){
    return (val == null || val.isEmpty) ? "请输入姓名": null;
  }
  void nameSave(val){
     doctor.name=val;
  }
  String mcValidate(val){
    return (val == null || val.isEmpty) ? "请输入药店名称": null;
  }
  void mcSave(val){
     doctor.yaodian_mc=val;
  }
  String zydwValidate(val){
    return (val == null || val.isEmpty) ? "请输入执业单位名称": null;
  }
  void zydwSave(val){
    doctor.zydw=val;
  }
  String deptValidate(val){
    return (val == null || val.isEmpty) ? "请输入所在科室名称": null;
  }
  void deptSave(val){
    doctor.dept=val;
  }
  String zyzbmValidate(val){
    return (val == null || val.isEmpty) ? "请输入医师执业证号": null;
  }
  void zyzbmSave(val){
    doctor.zyzbm=val;
  }
  String zgzbmValidate(val){
    return (val == null || val.isEmpty) ? "请输入医师资格证号": null;
  }
  void zgzbmSave(val){
    doctor.zgzbm=val;
  }
  String sfzhValidate(val){
    return (val == null || val.isEmpty) ? "请输入身份证号": null;
  }
  void sfzhSave(val){
    doctor.sfzh=val;
  }
  String jianjieValidate(val){
    return (val == null || val.isEmpty) ? "请输入擅长领域": null;
  }
  void jianjieSave(val){
     doctor.jianjie=val;
  }
  String mobileValidate(val){
    return (val == null || val.isEmpty) ? "请输入手机号码": null;
  }
  void mobileSave(val){
    doctor.mobile=val;
  }
  String usernameValidate(val){
    return (val == null || val.isEmpty) ? "请输入登录账号": null;
  }
  void usernameSave(val){
    doctor.username=val;
  }
  String pwdValidate(val){
    return (val == null || val.length<5) ? "请输入长度不小于5位的密码": null;
  }
  void pwdSave(val){
    doctor.password=val;
  }
  String againPwdValidate(val){
    return (val !=  pwdController.text|| val.isEmpty) ? "密码不一致": null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:  ListView(
        children: <Widget>[
          RegisterRowComponent(controller: this.ydController,isPass: false,label: "药店名称",hintText: "",displayOnly: true,keyNumberOnly: false),
          RegisterRowComponent(controller: this.nameController, isPass: false,label: "医师姓名",hintText: "请输入医师姓名",displayOnly: false,keyNumberOnly: false,save:(val)=>nameSave(val),validate: (val)=>nameValidate(val),),
          RegisterRowComponent(controller: this.zydwController, isPass: false,label: "执业单位",hintText: "请输入执业单位",displayOnly: false,keyNumberOnly: false,save:(val)=>zydwSave(val),validate: (val)=>zydwValidate(val),),
          RegisterRowComponent(controller: this.deptController, isPass: false,label: "所在科室",hintText: "请输入所在科室",displayOnly: false,keyNumberOnly: false,save:(val)=>deptSave(val),validate: (val)=>deptValidate(val),),
          RegisterRowComponent(controller: this.zyzbmController, isPass: false,label: "医师执业证号",hintText: "请输入医师执业证号",displayOnly: false,keyNumberOnly: false,save:(val)=>zyzbmSave(val),validate: (val)=>zyzbmValidate(val),),
          RegisterRowComponent(controller: this.zgzbmController, isPass: false,label: "医师资格证号",hintText: "请输入医师资格证号",displayOnly: false,keyNumberOnly: false,save:(val)=>zgzbmSave(val),validate: (val)=>zgzbmValidate(val),),
          RegisterRowComponent(controller: this.sfzhController,isPass: false,label: "身份证号",hintText: "请输入身份证号",displayOnly: false,keyNumberOnly: false,save:(val)=>sfzhSave(val),validate: (val)=>sfzhValidate(val)),
          //RegisterRowComponent(controller: this.jianjieController,isPass: false,label: "简介/擅长",hintText: "请输入擅长领域",displayOnly: false,keyNumberOnly: false,save:(val)=>jianjieSave(val),validate: (val)=>jianjieValidate(val)),
          JianjieRow(label: "简介/擅长",hintText: "请输入擅长领域",controller: this.jianjieController,validate: (val)=>jianjieValidate(val),save: (val)=>jianjieSave(val),),
          RegisterRowComponent(controller: this.mobileController,isPass: false,label: "手机号码",hintText: "请输入手机号码",displayOnly: false,keyNumberOnly: true,save:(val)=>mobileSave(val),validate: (val)=>mobileValidate(val)),
          RegisterRowComponent(controller: this.usernameController,isPass: false,label: "登录账号",hintText: "请输入登录账号",displayOnly: false,keyNumberOnly: false,save:(val)=>usernameSave(val),validate: (val)=>usernameValidate(val)),
          RegisterRowComponent(controller: this.pwdController,isPass: true,label: "登录密码",hintText: "请输入密码",displayOnly: false,keyNumberOnly: false,save:(val)=>pwdSave(val),validate: (val)=>pwdValidate(val)),
          RegisterRowComponent(controller: this.againPwdController,isPass: true,label: "",hintText: "请再次输入密码",displayOnly: false,keyNumberOnly: false,validate: (val)=>againPwdValidate(val)),
          RegisterButtonComponent(callback: onSubmit,)
        ],
      ),
    );

  }
}


