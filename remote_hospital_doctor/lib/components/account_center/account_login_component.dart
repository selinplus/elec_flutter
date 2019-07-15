import 'package:flutter/material.dart';
import './password_edit_row_component.dart';
import './password_edit_button_component.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import '../../models/mendian.dart';
class AccountLoginComponent extends StatelessWidget {
  final String label;
  final String value;
//  final Mendian md;
  //final TextEditingController controller;
  final callback;
  AccountLoginComponent({this.label,this.value,this.callback});
  _onPasswordChange(val){
    callback(val);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          //指定跳转的页面
          return EditPassPage(callback: (val)=>_onPasswordChange(val));
        },));
      },
      child: Container(
          color:Colors.white,
          child:Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
//           color: Colors.red,
                  width: 90.0,
                  height: 40.0,
                  child:Text("$label",style: TextStyle(fontSize: 14))
              ),
              Expanded(
                  child: Container(
//             color: Colors.blue,
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    height: 40.0,
                    child: Text("$value", style: TextStyle(fontSize: 14),
                    ),
                  )//
              ),
              Container(
                    padding: EdgeInsets.only(right:10.0),
                    child: Icon(Icons.arrow_forward_ios,size: 14.0,color: Theme.of(context).accentColor),
              )
            ],
          )
      )
    );

  }
}


class EditPassPage extends StatelessWidget{
//   final Mendian md;
   final TextEditingController pwdController = TextEditingController();
   final TextEditingController againPwdController = TextEditingController();
   final callback;
   EditPassPage({this.callback});

   _onPasswordChanged(){
     if(pwdController.text==""){
       Fluttertoast.showToast(
           msg: '密码不能为空',
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIos: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white
       );
       return;
     }
     if(againPwdController.text!=pwdController.text){
       Fluttertoast.showToast(
           msg: '两次输入的密码不一致',
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIos: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white
       );
       return;
     }
     callback(pwdController.text);
     //print(pwdController.text);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("更该密码",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: ListView(
        children: <Widget>[
          PasswordEditRowComponent(label: "请输入新密码",controller: this.pwdController,),
          Divider(height: 1.0,),
          PasswordEditRowComponent(label: "请再次输入新密码",controller: this.againPwdController,),
          Divider(height: 1.0,),
          PasswordEditButtonComponent(callback: _onPasswordChanged,)
        ],
      )
    );
  }
}




