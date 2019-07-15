import 'package:flutter/material.dart';
import 'package:remote_hospital_manager/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_manager/services/pref_util.dart';
import 'package:remote_hospital_manager/models/yaodian.dart';
//import 'package:remote_hospital_doctor/screens/register_page.dart';
//import 'package:remote_hospital_doctor/models/yaodian.dart';
//import 'package:remote_hospital_manager/models/doctor.dart';
class LoginComponent extends StatefulWidget {
  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String token;
  Yaodian yaodian=Yaodian.name();
//  Doctor doctor =Doctor.name();

  @override
  Widget build(BuildContext context) {
    return Form(
      key:_formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            flex:1,
            child: Container(),
          ),
          Expanded(
            flex:2,
            child:Container(
//              padding: EdgeInsets.only(top:90.0),
//              height: 150.0,
              alignment: Alignment.center,
              child: Text("视频问诊系统管理端",style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor)),
            ) ,
          ),
          Expanded(
            flex: 6,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal:60.0),
                  child: TextFormField(
                    controller: accountController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                    validator: (val){
                      return (accountController.text == null || accountController.text.isEmpty) ? "登录账号不能为空": null;
                    },
                    onSaved: (val){
                      yaodian.username=accountController.text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.account_box,
                          color:Theme.of(context).accentColor
                      ),
                      hintText: "请输入登录名",
                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:60.0),
                  child: TextFormField(
                    controller: passController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                    obscureText: true,
                    validator: (val){
                      return (val == null || val.isEmpty) ? "密码不能为空": null;
                    },
                    onSaved: (val){
                    yaodian.password=val;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.lock,
                          color:Theme.of(context).accentColor
                      ),
                      hintText: "请输入密码",
                      hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 10.0),
                  padding: EdgeInsets.only(top:10.0,left:60,right:60),
                  //constraints: BoxConstraints.expand(),
                  child: RaisedButton(
                    color:Theme.of(context).accentColor,
                    colorBrightness: Brightness.dark,
                    textColor: Colors.white,
                    child: Text("登录"),
                    onPressed: (){
                      var _form = _formKey.currentState;
                      if(_form.validate()) {
                        _form.save();
                        print(yaodian.toJson());
                        //Navigator.of(context).pushReplacementNamed("/main");
//                        getPrefString("licence").then((val){
//                          mendian.licence=val;
                          // Map params={"licence":"1234567890abcdef","username":"yxt0001","password":"123456"};
                        DioUtil().get(false, '/yaodian/auth',queryParameters:yaodian.toJson(),
                            errorCallback: (statuscode){
                              print('http error code :$statuscode');
                              Fluttertoast.showToast(
                                  msg: 'http error code :$statuscode',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor:Colors.red,
                                  textColor: Colors.white
                              );
                            }).then((data){
                          print(data);
                          print('http response: ${data["code"].toString()}');
                          if(data["code"]==200){
                            if(data["data"] is Map){
                              Map map =data["data"];
                              if(map["data"] is Map ){
                                print(map["data"]);
                                print(map["token"]);
                                print(data["data"]["data"]);
                                setPrefInt("ydid", map["data"]["ID"])
                                    .then((_)=>setPrefString("ydmc", map["data"]["mc"]))
                                    .then((_)=>setPrefString("username", map["data"]["username"]))
                                    .then((_)=>setPrefString("password", map["data"]["password"]))
                                    .then((_)=>setPrefString("token",map["token"]))
                                    .then((_){
                                  Navigator.of(context).pushReplacementNamed("/main");
                                });
                              }
                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: "登录失败,${data['code']}: ${data['msg']}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor:Colors.red,
                                textColor: Colors.white
                            );
                          }
                        });
                        }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


