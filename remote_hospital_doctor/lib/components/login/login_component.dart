import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'package:remote_hospital_doctor/screens/register_page.dart';
import 'package:remote_hospital_doctor/models/yaodian.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
class LoginComponent extends StatefulWidget {
  final initWebsocket;
  LoginComponent({this.initWebsocket});
  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String token;
  Yaodian yaodian;
  Doctor doctor =Doctor.name();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int ydid;
    String ydmc;
    DioUtil().get(false, "/yaodian",
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
        }
    ).then((data) {
      print("data:");
      print("-------------------------------------------");
      print(data);
      print('http response: ${data["code"]}');
      yaodian = Yaodian.fromJson(data["data"]);
      setPrefInt("ydid", yaodian.ID);
    }).then((_){
      setPrefString("ydmc",yaodian.mc);
      print(yaodian.mc);
    }).then((_){
      return getPrefString("username");
    }).then((val){
      print("username:"+val);
      doctor.username=val;
      accountController.text=doctor.username;
      return getPrefString("token");
    }).then((val){
      print("token:"+val);
      token=val;
      return getPrefString("password");
    }).then((val){
      print("password:"+val);
      doctor.password=val;
      if (token!=""&&doctor.username!=""&&doctor.password!=""){
        print("已进入自动登录");
        DioUtil().get(false, '/yishi/auth',queryParameters:doctor.toJson(),
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
            }
        ).then((data){
          print('http response: ${data["code"]}');
          if(data["code"]==200){
            if(data["data"] is Map){
              Map map =data["data"];
              if(map["data"] is Map ){
                //print("map[data]:"+map["data"]);
                print("avator:"+map["data"]["avator_uri"]);
                //print(map["token"]);
                print(data["data"]);
                setPrefString("doctorname", map["data"]["name"])
                    .then((_)=>setPrefString("zydw", map["data"]["zydw"]))
                    .then((_)=>setPrefString("sfzh", map["data"]["sfzh"]))
                    .then((_)=>setPrefString("dept", map["data"]["dept"]))
                    .then((_)=>setPrefString("zyzbm", map["data"]["zyzbm"]))
                    .then((_)=>setPrefString("zgzbm", map["data"]["zgzbm"]))
                    .then((_)=>setPrefString("jianjie", map["data"]["jianjie"]))
                    .then((_)=>setPrefString("mobile", map["data"]["mobile"]))
                    .then((_)=>setPrefBool("review", map["data"]["review"]))
                    .then((_)=>setPrefString("username", map["data"]["username"]))
                    .then((_)=>setPrefString("password", map["data"]["password"]))
                    .then((_)=>setPrefInt("doctorid", map["data"]["ID"]))
                    .then((_)=>setPrefString("token",map["token"]))
                    .then((_)=>setPrefString("avator_uri",map["data"]["avator_uri"]))
                    .then((_)=>setPrefString("zyz_uri",map["data"]["zyz_uri"]))
                    .then((_)=>setPrefString("zgz_uri",map["data"]["zgz_uri"]))
                    .then((_)=>setPrefString("qz_uri",map["data"]["qz_uri"]))
                    .then((_)=>widget.initWebsocket())
                    .then((_){
                  Navigator.of(context).pushReplacementNamed("/main");
                  return;
                });
              }
            }
          }else{
//            Fluttertoast.showToast(
//                msg: "登录失败,${data['code']}: ${data['msg']}",
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.CENTER,
//                timeInSecForIos: 1,
//                backgroundColor:Colors.red,
//                textColor: Colors.white
//            );
          }
        });
      }
      //Navigator.of(context).pushReplacementNamed("/main");
//      if(ydid!=0&&ydmc!=""){
//        yaodian=Yaodian(ydid, ydmc);
//      }else{
//        DioUtil().get(false, "/yaodian",
//            errorCallback: (statuscode){
//              print('http error code :$statuscode');
//              Fluttertoast.showToast(
//                  msg: 'http error code :$statuscode',
//                  toastLength: Toast.LENGTH_SHORT,
//                  gravity: ToastGravity.CENTER,
//                  timeInSecForIos: 1,
//                  backgroundColor:Colors.red,
//                  textColor: Colors.white
//              );
//            }
//        ).then((data){
//          print('http response: ${data["code"]}');
//          yaodian=Yaodian.fromJson(data["data"]);
//          setPrefInt("ydid", yaodian.ID);
//          setPrefString("ydmc",yaodian.mc);
//          print(yaodian.mc);
//          // ydController.text= yaodian.mc;
//        });
//      }
    });
//      DioUtil().get(false, "/yaodian",
//          errorCallback: (statuscode){
//            print('http error code :$statuscode');
//            Fluttertoast.showToast(
//                msg: 'http error code :$statuscode',
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.CENTER,
//                timeInSecForIos: 1,
//                backgroundColor:Colors.red,
//                textColor: Colors.white
//            );
//          }
//      ).then((data){
//        print('http response: ${data["code"]}');
//        yaodian=Yaodian.fromJson(data["data"]);
//        setPrefInt("ydid", yaodian.ID);
//        setPrefString("ydmc",yaodian.mc);
//        print(yaodian.mc);
//        // ydController.text= yaodian.mc;
//      });

  }
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
              child: Text("视频问诊系统医师端",style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor)),
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
                      doctor.username=accountController.text;
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
                    doctor.password=val;
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
                        print(doctor.toJson());
//                        getPrefString("licence").then((val){
//                          mendian.licence=val;
                          // Map params={"licence":"1234567890abcdef","username":"yxt0001","password":"123456"};
                     DioUtil().get(false, '/yishi/auth',queryParameters:doctor.toJson(),
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
                                  setPrefString("doctorname", map["data"]["name"])
                                      .then((_)=>setPrefString("zydw", map["data"]["zydw"]))
                                      .then((_)=>setPrefString("sfzh", map["data"]["sfzh"]))
                                      .then((_)=>setPrefString("dept", map["data"]["dept"]))
                                      .then((_)=>setPrefString("zyzbm", map["data"]["zyzbm"]))
                                      .then((_)=>setPrefString("zgzbm", map["data"]["zgzbm"]))
                                      .then((_)=>setPrefString("jianjie", map["data"]["jianjie"]))
                                      .then((_)=>setPrefString("mobile", map["data"]["mobile"]))
                                      .then((_)=>setPrefBool("review", map["data"]["review"]))
                                      .then((_)=>setPrefString("username", map["data"]["username"]))
                                      .then((_)=>setPrefString("password", map["data"]["password"]))
                                      .then((_)=>setPrefInt("doctorid", map["data"]["ID"]))
                                      .then((_)=>setPrefString("token",map["token"]))
                                      .then((_)=>setPrefString("avator_uri",map["data"]["avator_uri"]))
                                      .then((_)=>setPrefString("zyz_uri",map["data"]["zyz_uri"]))
                                      .then((_)=>setPrefString("zgz_uri",map["data"]["zgz_uri"]))
                                      .then((_)=>setPrefString("qz_uri",map["data"]["qz_uri"]))
                                      .then((_)=>widget.initWebsocket())
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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top:10.0),
                  child:GestureDetector(
                      child: Text(
                        "医师注册",
                        style: TextStyle(
                            color:Theme.of(context).accentColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline
                        ),
                      ),
                      onTap:(){
                        if(yaodian !=null){
                          //Navigator.of(context).pushNamed("/register");
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //指定跳转的页面
                            return RegisterPage(yaodian: yaodian,initWebsocket: widget.initWebsocket,);
                          },));
                        }else{
                          Fluttertoast.showToast(
                              msg: "药店信息加载失败!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor:Colors.red,
                              textColor: Colors.white
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


