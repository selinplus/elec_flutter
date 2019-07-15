import 'package:flutter/material.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:remote_hospital/models/yaodian.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/screens/register_page.dart';
import 'package:remote_hospital/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/services/pref_util.dart';
import 'package:remote_hospital/config.dart';
class LoginComponent extends StatefulWidget {
  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Yaodian yaodian;
  Mendian mendian= Mendian.name();
  String token;
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
      print('http response: ${data["code"]}');
      yaodian = Yaodian.fromJson(data["data"]);
      setPrefInt("ydid", yaodian.ID);
    }).then((_){
      setPrefString("ydmc",yaodian.mc);
      print(yaodian.mc);
    }).then((_) {
      return getPrefString("licence");
    }).then((val){
      mendian.licence=val;
      return getPrefString("username");
    }).then((val){
      print("username:"+val);
      mendian.username=val;
      accountController.text=mendian.username;
      return getPrefString("token");
    }).then((val){
      print("token:"+val);
      token=val;
      return getPrefString("password");
    }).then((val){
      print("password:"+val);
      mendian.password=val;
      mendian.version=Config.VERSION;
      if (token!=""&&mendian.username!=""&&mendian.password!=""){
        print("已进入自动登录");
        DioUtil().get(false, '/mendian/auth',queryParameters:mendian.toJson(),
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
              //Mendian _mendian=Mendian.fromJson(data["data"]);
              Map map =data["data"];
              if(map["data"] is Map ){
                print(map["data"]);
                print(map["data"]["licence"]);
                print(map["token"]);
                print(data["data"]);
                setPrefString("mdmc", map["data"]["mc"])
                    .then((_)=>setPrefString("licence", map["data"]["licence"]))
                    .then((_)=>setPrefString("fzr", map["data"]["fzr"]))
                    .then((_)=>setPrefString("dianhua", map["data"]["dianhua"]))
                    .then((_)=>setPrefString("username", map["data"]["username"]))
                    .then((_)=>setPrefString("password", map["data"]["password"]))
//                    .then((_)=>setPrefString("yaosshuri", map["data"]["yaosshuri"]))
                    .then((_)=>setPrefInt("mdid", map["data"]["ID"]))
                    .then((_)=>setPrefString("token",map["token"]))
                    .then((_){
                  //print("门店名称：111111"+data["data"]["mc"]);
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
    });
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
              child: Text("视频问诊系统药店端",style: TextStyle(fontSize: 20,color: Theme.of(context).accentColor)),
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
                       mendian.username=accountController.text;
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
                      mendian.password=val;
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
                          print(mendian.toJson());
                          getPrefString("licence").then((val) {
                            mendian.licence = val;
                            mendian.version=Config.VERSION;
                            // Map params={"licence":"1234567890abcdef","username":"yxt0001","password":"123456"};
                            DioUtil().get(false, '/mendian/auth',
                                queryParameters: mendian.toJson(),
                                errorCallback: (statuscode) {
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
                              print(data);
                              print(
                                  'http response: ${data["code"].toString()}');
                              if (data["code"] == 200) {
                                if (data["data"] is Map) {
                                  Map map = data["data"];
                                  if (map["data"] is Map) {
                                    print(map["data"]);
                                    print(map["data"]["licence"]);
                                    print(map["token"]);
                                    // print(data["data"]["data"]);
                                    setPrefString("mdmc", map["data"]["mc"])
                                        .then((_) => setPrefString(
                                        "licence", map["data"]["licence"]))
                                        .then((_) => setPrefString(
                                        "fzr", map["data"]["fzr"]))
                                        .then((_) => setPrefString(
                                        "dianhua", map["data"]["dianhua"]))
                                        .then((_) => setPrefString("username",
                                        map["data"]["username"]))
                                        .then((_) => setPrefString("password",
                                        map["data"]["password"]))
//                                        .then((_) => setPrefString("yaosshuri",
//                                        map["data"]["yaosshuri"]))
                                        .then((_) =>
                                        setPrefInt("mdid", map["data"]["ID"]))
                                        .then((_) =>
                                        setPrefString("token", map["token"]))
                                        .then((_) {
                                      Navigator.of(context)
                                          .pushReplacementNamed("/main");
                                    });
                                  }
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "登录失败,${data['code']}: ${data['msg']}",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white
                                );
                              }
                            });
                          });
                        //Navigator.of(context).pushReplacementNamed("/main");
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top:10.0),
                  child:GestureDetector(
                    child: Text(
                      "门店注册",
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
                          return RegisterPage(yaodian: yaodian,);
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


