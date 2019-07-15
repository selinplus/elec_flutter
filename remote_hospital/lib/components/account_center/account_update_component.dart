import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:remote_hospital/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:remote_hospital/config.dart';
//import 'package:install_plugin/install_plugin.dart';
import 'dart:io';
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
                    DioUtil().get(true, "/export/drugstore.json", errorCallback: (statuscode) {
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
       launch(Config.BASE_URL+"/export/drugstore.apk");
   }
   getUpdate() async {
     bool permission = await requestPermission();
     if (permission) {
       await executeDownload();
     }
   }
  // 获取安装地址
  Future<String> get _apkLocalPath async {
    final directory = await getExternalStorageDirectory();
//    final directory = await getTemporaryDirectory();
    return directory.path;
  }
// 下载
  Future<void> executeDownload() async {
    final path = await _apkLocalPath;
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: 'https://ytsw.info:4443/export/app-debug.apk',
        savedDir: path,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
       // print("下载完毕");
       //_installApk();
        //InstallPlugin.installApk( path + '/drugstore.apk', "com.bigear.remote_hospital");
      }

    });
  }
// 安装
  Future<Null> _installApk() async {
    // XXXXX为项目名
    const platform = const MethodChannel("com.bigear.remote_hospital");
    try {
      final path = await _apkLocalPath;
      // 调用app地址
      await platform.invokeMethod('install', {'path': path + '/drugstore.apk'});
    } on PlatformException catch (_) {}
  }
  //是否有权限
  Future<bool> checkPermission() async {
//    bool res = await SimplePermissions.checkPermission(
//        Permission.WriteExternalStorage);
//    return res;
  }

  //打开权限
//  Future<PermissionStatus> requestPermission() async {
//    return SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//  }
  Future<bool> requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      print("okokokokoko");
     return true;

    } else {
     return false;
    }
  }

}





