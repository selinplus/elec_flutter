import 'package:flutter/material.dart';
import './register_row_component.dart';
import './register_button_component.dart';
import '../../models/mendian.dart';
import '../../models/yaodian.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/services/pref_util.dart';
class RegisterComponent extends StatefulWidget {
  Yaodian yaodian;
  RegisterComponent({this.yaodian});
  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //Yaodian yaodian;//=Yaodian();

  Mendian mendian=Mendian.name();
  TextEditingController ydController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController mdController = TextEditingController();
  TextEditingController fzrController = TextEditingController();
  TextEditingController dianhuaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController againPwdController = TextEditingController();

   void onSubmit(){
     var _form = _formKey.currentState;
     if(_form.validate()){
       _form.save();
       print(mendian.toJson());
//       setPrefString("mdmc",mendian.mc);
//       setPrefString("licence",mendian.licence);
//       setPrefString("fzr",mendian.fzr);
//       setPrefString("dianhua", mendian.dianhua);
//       setPrefString("username", mendian.username);
//       setPrefString("password", mendian.password);
       DioUtil().post(false, "/mendian/reg",data: mendian.toJson(),
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
           setPrefString("licence",mendian.licence)
               .then((_){
                      setPrefString("username",mendian.username);
                }).then((_){
                   //Navigator.of(context).pop();
                   Navigator.pushNamedAndRemoveUntil(context,'/login', (Route<dynamic> route) => false);
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
    mendian.yaodian_id=widget.yaodian.ID;
  }

  String licenceValidate(val){
    return (val == null || val.length<16) ? "请输入不小于16位的注册码": null;
  }
  void licenceSave(val){
     mendian.licence=val;
  }
  String mcValidate(val){
    return (val == null || val.isEmpty) ? "请输入门店名称": null;
  }
  void mcSave(val){
    mendian.mc=val;
  }
  String fzrValidate(val){
    return (val == null || val.isEmpty) ? "请输入门店负责人名称": null;
  }
  void fzrSave(val){
    mendian.fzr=val;
  }
  String dianhuaValidate(val){
    return (val == null || val.isEmpty) ? "请输入电话": null;
  }
  void dianhuaSave(val){
    mendian.dianhua=val;
  }
  String usernameValidate(val){
    return (val == null || val.isEmpty) ? "请输入登录账号": null;
  }
  void usernameSave(val){
    mendian.username=val;
  }
  String pwdValidate(val){
    return (val == null || val.length<5) ? "请输入长度不小于5位的密码": null;
  }
  void pwdSave(val){
    mendian.password=val;
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
          RegisterRowComponent(controller: this.licenceController, isPass: false,label: "门店注册码",hintText: "请输入注册码",displayOnly: false,keyNumberOnly: false,save:(val)=>licenceSave(val),validate: (val)=>licenceValidate(val),),
          RegisterRowComponent(controller: this.mdController,isPass: false,label: "门店名称",hintText: "请输入门店名称",displayOnly: false,keyNumberOnly: false,save:(val)=>mcSave(val),validate: (val)=>mcValidate(val)),
          RegisterRowComponent(controller: this.fzrController,isPass: false,label: "门店负责人",hintText: "请输入负责人",displayOnly: false,keyNumberOnly: false,save:(val)=>fzrSave(val),validate: (val)=>fzrValidate(val)),
          RegisterRowComponent(controller: this.dianhuaController,isPass: false,label: "电话",hintText: "请输入电话号码",displayOnly: false,keyNumberOnly: true,save:(val)=>dianhuaSave(val),validate: (val)=>dianhuaValidate(val)),
          RegisterRowComponent(controller: this.usernameController,isPass: false,label: "登录账号",hintText: "请输入登录账号",displayOnly: false,keyNumberOnly: true,save:(val)=>usernameSave(val),validate: (val)=>usernameValidate(val)),
          RegisterRowComponent(controller: this.pwdController,isPass: true,label: "登录密码",hintText: "请输入密码",displayOnly: false,keyNumberOnly: false,save:(val)=>pwdSave(val),validate: (val)=>pwdValidate(val)),
          RegisterRowComponent(controller: this.againPwdController,isPass: true,label: "",hintText: "请再次输入密码",displayOnly: false,keyNumberOnly: false,validate: (val)=>againPwdValidate(val)),
          RegisterButtonComponent(callback: onSubmit,)
        ],
      ),
    );

  }
}


