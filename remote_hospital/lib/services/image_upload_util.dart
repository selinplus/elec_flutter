import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as Img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui'as ui;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:remote_hospital/services/dio_util.dart';

final String scrawlImagePath = 'dart.png';

Future<String>_saveImage(Uint8List uint8List, Directory dir, String fileName) async {
//  bool isDirExist = await Directory(dir.path).exists();
//  if (!isDirExist) Directory(dir.path).create();
  String tempPath = '${dir.path}/$fileName';
  print(uint8List);
  print(tempPath);
  File image = File(tempPath);
  bool isExist = await image.exists();
  if (isExist) await image.delete();
  final imageFile=File(tempPath);
  return  imageFile.writeAsBytes(uint8List).then((_){
         return imageFile.path;
  });
//  print(imageFile.path);
//  print(imageFile.statSync());
//  return imageFile.path;
}

Future<Uint8List> capturePng2List(RenderRepaintBoundary boundary,double pr) async {
  ui.Image image = await boundary.toImage(pixelRatio:pr);
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();
  return pngBytes;
}


Future<String>  upLoadPng( RenderRepaintBoundary boundary,double pr, {Function success, Function fail} ) async{
  return capturePng2List(boundary,pr).then((uint8List) async {
    if (uint8List == null || uint8List.length == 0) {
      if (fail != null) fail();
      print("capture error");
      return null;
    }
    Directory tempDir = await getApplicationDocumentsDirectory();
   return  _saveImage(uint8List, tempDir, scrawlImagePath).then((val){
        if(val==null||val=="") {
          if (fail != null) fail();
          print("save error");
          return null;
        }
        print("val:"+val);
        FormData formData = new FormData.from({
          "image": new UploadFileInfo(new File(val), scrawlImagePath,
              contentType: ContentType.parse("image/png"))
        });
       return DioUtil().post(true, "/upload",data: formData,
        errorCallback:fail).then((data){
          print(data);
          if(data["code"]==200) {
            print(data);
            if (data["data"] is Map) {
              return data["data"]["image_url"].toString();
            }
          }else{
            if (fail != null) fail();
            print("return error");
            return null;
          }
        });
    });
  });
}

