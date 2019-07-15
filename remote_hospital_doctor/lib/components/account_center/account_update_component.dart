import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:remote_hospital_doctor/config.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:remote_hospital_doctor/config.dart';
class AccountUpdateComponent extends StatelessWidget {
  final String label;
  AccountUpdateComponent({this.label});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            //指定跳转的页面
            return UpdatePage();
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
                    width: 150.0,
                    height: 40.0,
                    child:Text("$label",style: TextStyle(fontSize: 14))
                ),
                Expanded(
                  child: Container(
                    height: 40,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right:10.0),
                  child: Icon(Icons.cloud_download,size: 14.0,color: Theme.of(context).accentColor),
                )
              ],
            )
        )
    );

  }
}


class UpdatePage extends StatefulWidget {

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String newVersion;
  bool needUpdate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("系统更新", style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme
                  .of(context)
                  .accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize: Size.fromHeight(40)
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: RaisedButton(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  textColor: Theme
                      .of(context)
                      .accentColor,
                  child: Text("检查更新", style: TextStyle(fontSize: 12)),
                  color: Colors.white,
                  shape: Border.all(
                      color: Theme
                          .of(context)
                          .accentColor,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  onPressed: () {
                    DioUtil().get(true, "/export/doctor.json", errorCallback: (statuscode) {
                      print('http error code :$statuscode');
                      Fluttertoast.showToast(
                          msg: 'http error code :$statuscode',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white
                      );
                    }).then((data) {
                      print(data);
                      if (data is Map) {
                        setState(() {
                          newVersion = data['version'];
                          needUpdate =
                              newVersion.compareTo(Config.VERSION) == 1;
                        });
                        if(!needUpdate){
                          Fluttertoast.showToast(
                              msg: '当前已经是最新版本',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white
                          );
                        }
                      }
                    });
                  }
              ),
            ),
            Center(
              child: Text("当前版本：${Config.VERSION}",style: TextStyle(fontSize: 12)),
            ),
            Center(
              child: needUpdate ? Text("有新版本：$newVersion",style: TextStyle(fontSize: 12)):null,
            ),
            Center(
              child:needUpdate?RaisedButton(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  textColor: Theme
                      .of(context)
                      .accentColor,
                  child: Text("获取更新", style: TextStyle(fontSize: 12)),
                  color: Colors.white,
                  shape: Border.all(
                      color: Theme
                          .of(context)
                          .accentColor,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  onPressed: () {
                    downloadApk();
                  }
              ):null,
            ),
          ],)
    );
  }

   downloadApk() {
       launch(Config.BASE_URL+"/export/doctor.apk");
   }

}





