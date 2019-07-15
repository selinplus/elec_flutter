import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remote_hospital_doctor/screens/photo_page.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';

class IdentifiedComponent extends StatefulWidget {
  Doctor doctor;
  IdentifiedComponent({this.doctor});
  @override
  _IdentifiedComponentState createState() => _IdentifiedComponentState();
}

class _IdentifiedComponentState extends State<IdentifiedComponent> {
  Doctor _doctor;
  bool _isAvator=false;
  bool _isZyz =false;
  bool _isZgz =false;

  initState(){
    _doctor=widget.doctor;
    print("dcotor.zyz_uri:"+_doctor.zgz_uri);
    if(_doctor.avator_uri==""||_doctor.avator_uri==null||_doctor.avator_uri=="null"){
      _isAvator=false;
    }else{
      _isAvator=true;      
    }
    if(_doctor.zyz_uri==""||_doctor.zyz_uri==null||_doctor.zyz_uri=="null"){
      _isZyz=false;
    }else{
      _isZyz=true;
    }
    if(_doctor.zgz_uri==""||_doctor.zgz_uri==null||_doctor.zgz_uri=="null"){
      _isZgz=false;
    }else{
      _isZgz=true;
    }
  }
  toPhotoPage(String title,String url ){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      print("url:"+url);
      return PhotoPage(title: title,imageUrl: url);
    },));
  }
  Future getAvatorImage() async{
    String imageUri;
    ImagePicker.pickImage(source:ImageSource.gallery)
        .then((image){
              return _upLoadImage(image);
          }).then((imageUrl){
            print("iamageUrl:"+imageUrl);
            if (imageUrl=="") {
              return null;
            }
            imageUri=imageUrl;
            print("imageUrl:"+imageUri);
            Map<String,dynamic> params =Map<String,dynamic>();
            params["ID"]=_doctor.ID;
            params["avator_uri"]=imageUri;
            print("params:");
            print(params);
            return DioUtil().postWithJson(true, "/api/v1/yishi/upd/uri",data:params,
                errorCallback:(statuscode){
                  print('http error code :$statuscode');
                  Fluttertoast.showToast(
                      msg: 'http error code :$statuscode',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white
                  );
                });
          }).then((data){
              print("code");
              if(data!=null){
                if(data["code"]==200){
                  setPrefString("avator_uri",imageUri).then((_){
                    Fluttertoast.showToast(
                        msg: "照片上传成功",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor:Colors.green,
                        textColor: Colors.white
                    );
                    _isAvator=true;
                    _doctor.avator_uri=imageUri;
                    setState(() {
                    });
                  });
                }else{
                  Fluttertoast.showToast(
                      msg: "照片上传失败,${data['code']}: ${data['msg']}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor:Colors.red,
                      textColor: Colors.white
                  );
                }
              }else{
                Fluttertoast.showToast(
                    msg: "照片上传失败,${data['code']}: ${data['msg']}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor:Colors.red,
                    textColor: Colors.white
                );
              }
          });
  }
  Future getZyzImage() async{
    String imageUri;
    ImagePicker.pickImage(source:ImageSource.gallery)
        .then((image){
      return _upLoadImage(image);
    }).then((imageUrl){
      print("iamageUrl:"+imageUrl);
      if (imageUrl=="") {
        return null;
      }
      imageUri=imageUrl;
      print("imageUrl:"+imageUri);
      Map<String,dynamic> params =Map<String,dynamic>();
      params["ID"]=_doctor.ID;
      params["zyz_uri"]=imageUri;
      print("params:");
      print(params);
      return DioUtil().postWithJson(true, "/api/v1/yishi/upd/uri",data:params,
          errorCallback:(statuscode){
            print('http error code :$statuscode');
            Fluttertoast.showToast(
                msg: 'http error code :$statuscode',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          });
    }).then((data){
      print("code");
      if(data!=null){
        if(data["code"]==200){
          setPrefString("zyz_uri",imageUri).then((_){
            Fluttertoast.showToast(
                msg: "照片上传成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor:Colors.green,
                textColor: Colors.white
            );
            _isZyz=true;
            _doctor.zyz_uri=imageUri;
            setState(() {
            });
          });
        }else{
          Fluttertoast.showToast(
              msg: "照片上传失败,${data['code']}: ${data['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor:Colors.red,
              textColor: Colors.white
          );
        }
      }else{
        Fluttertoast.showToast(
            msg: "照片上传失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
      }
    });
  }
  Future getZgzImage() async{
    String imageUri;
    ImagePicker.pickImage(source:ImageSource.gallery)
        .then((image){
      return _upLoadImage(image);
    }).then((imageUrl){
      print("iamageUrl:"+imageUrl);
      if (imageUrl=="") {
        return null;
      }
      imageUri=imageUrl;
      print("imageUrl:"+imageUri);
      Map<String,dynamic> params =Map<String,dynamic>();
      params["ID"]=_doctor.ID;
      params["zgz_uri"]=imageUri;
      print("params:");
      print(params);

      return DioUtil().postWithJson(true, "/api/v1/yishi/upd/uri",data:params,
          errorCallback:(statuscode){
            print('http error code :$statuscode');
            Fluttertoast.showToast(
                msg: 'http error code :$statuscode',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          });
    }).then((data){
      print("code");
      if(data!=null){
        if(data["code"]==200){
          setPrefString("zgz_uri",imageUri).then((_){
            Fluttertoast.showToast(
                msg: "照片上传成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor:Colors.green,
                textColor: Colors.white
            );
            _isZgz=true;
            _doctor.zgz_uri=imageUri;
            setState(() {
            });
          });
        }else{
          Fluttertoast.showToast(
              msg: "照片上传失败,${data['code']}: ${data['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor:Colors.red,
              textColor: Colors.white
          );
        }
      }else{
        Fluttertoast.showToast(
            msg: "照片上传失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
      }
    });
  }
  _upLoadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    print("name:"+name);
    print("suffix:"+suffix);
    FormData formData = new FormData.from({
      "image": new UploadFileInfo(new File(path), name,
          contentType: ContentType.parse("image/$suffix"))
    });
     var data = await DioUtil().post(true, "/upload",data: formData,
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
     );
      print('http response: ${data["code"]}');
      if(data["code"]==200){
        if(data["data"] is Map){
          return data["data"]["image_url"].toString();
        }
      }else{
        Fluttertoast.showToast(
            msg: "照片上传失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return null;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
            child: Text(
              "你的身份认证资料已提交，请耐心等待，我们会在1个工作日内进行处理。",
              style: TextStyle(color: Colors.cyan,fontSize: 16,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child:  Container(
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("个人照片",style: TextStyle(fontSize: 18),),
                        Text("请上传清晰的免冠证件照",style: TextStyle(color: Colors.grey,fontSize: 14),)
                      ],
                    ),
                  ),
                ),
                Container(
                    width: 80,
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    child: GestureDetector(
                      child: Container(
                        color:Colors.white,
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        //color:Colors.red,
                        child: _isAvator?Image.network("${_doctor.avator_uri}"):Text("选择图片",style: TextStyle(fontSize: 15,color:Colors.green),),
                      ),
                      onTap:!_isAvator?(){
                        getAvatorImage();
                      }:(){
                        toPhotoPage("个人照片",_doctor.avator_uri);
                       },
                    )
                )
              ],
            ),
          ),
          Container(
              height:10.0
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child:  Container(
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("请上传胸牌或执业证书",style:TextStyle(fontSize: 18)),
                        Text("请确保头像、姓名、医院名称等信息清晰可见",style: TextStyle(color: Colors.grey,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
                Container(
                    width: 80,
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    child: GestureDetector(
                      child: Container(
                        color:Colors.white,
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        //color:Colors.red,
                        child: _isZyz?Image.network("${_doctor.zyz_uri}"):Text("选择图片",style: TextStyle(fontSize: 15,color:Colors.green),),
                      ),
                      onTap: !_isZyz?(){
                        getZyzImage();
                      }:(){
                         toPhotoPage("胸牌或职业资格证",_doctor.zyz_uri);
                      },
                    )
                ),
              ],
            ),
          ),
          Container(
              height:10.0
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child:  Container(
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("请上传职业资格证书",style:TextStyle(fontSize: 18)),
                        Text("请确保头像、资格证号等信息清晰可见",style: TextStyle(color: Colors.grey,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
                Container(
                    width: 80,
                    height: 80,
                    decoration:BoxDecoration(
                        color:  Colors.white,
                        border: Border.all(
                            color: Colors.grey[400],
                            width: 0.5
                        )
                    ),
                    child: GestureDetector(
                      child: Container(
                        color:Colors.white,
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        //color:Colors.red,
                        child: _isZgz?Image.network("${_doctor.zgz_uri}"):Text("选择图片",style: TextStyle(fontSize: 15,color:Colors.green),),
                      ),
                      onTap:!_isZgz?(){
                        getZgzImage();
                      }:(){
                        toPhotoPage("职业资格证书",_doctor.zgz_uri);
                      },
                    )
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 30,right: 30,top:20),
//            height: 40,
            child: Text("*信息认证成功后暂不支持修改，以上证书及个人信息只用作认证，不向用户展示",style: TextStyle(color: Colors.grey,fontSize: 15),),

          ),

        ],
      ),
    );
  }
}
