import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/patient/label_text_row_component.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/screens/photo_page.dart';
import 'package:remote_hospital_doctor/components/doctor/doctor_detail_page.dart';

class DoctorDetailInfo extends StatefulWidget {
  Doctor doctor;
  DoctorDetailInfo({this.doctor});
  @override
  _DoctorDetailInfoState createState() => _DoctorDetailInfoState();
}

class _DoctorDetailInfoState extends State<DoctorDetailInfo> {
  Doctor doctor;
  void initState(){
    doctor=widget.doctor;
  }
  toPhotoPage(String title,String url ){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      print("url:"+url);
      return PhotoPage(title: title,imageUrl: url);
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child:   ListView(
          children: <Widget>[
            LabelTextRowComponent(label: "医师姓名",value: doctor.name,),
            Divider(height: 1,),
            LabelTextRowComponent(label: "执业单位",value: doctor.zydw,),
            Divider(height: 1,),
            LabelTextRowComponent(label: "所在科室",value:doctor.dept),
            Divider(height: 1,),
            LabelTextRowComponent(label: "简介",value:doctor.jianjie),
            Divider(height: 1,),
            LabelTextRowComponent(label: "手机号码",value: doctor.mobile,),
            Divider(height: 1,),
            LabelTextRowComponent(label: "身份证号",value:doctor.sfzh),
            Divider(height: 1,),
            LabelTextRowComponent(label: "执业医师证号",value: doctor.zyzbm),
            Divider(height: 1,),
            LabelTextRowComponent(label: "执业资格证号",value: doctor.zgzbm),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
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
//                          Text("请上传清晰的免冠证件照",style: TextStyle(color: Colors.grey,fontSize: 14),)
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
                          child: doctor.avator_uri==null||doctor.avator_uri==""?Text("尚未上传",style: TextStyle(fontSize: 15,color:Colors.green),):Image.network("${doctor.avator_uri}")
                        ),
                        onTap:doctor.avator_uri==null||doctor.avator_uri==""?(){}:(){
                          toPhotoPage("个人照片",doctor.avator_uri);
                        },
                      )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
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
                          Text("胸牌或执业证书",style: TextStyle(fontSize: 18),),
//                          Text("请上传清晰的免冠证件照",style: TextStyle(color: Colors.grey,fontSize: 14),)
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
                            child: doctor.zyz_uri==null||doctor.zyz_uri==""?Text("尚未上传",style: TextStyle(fontSize: 15,color:Colors.green),):Image.network("${doctor.zyz_uri}")
                        ),
                        onTap:doctor.zyz_uri==null||doctor.zyz_uri==""?(){}:(){
                          toPhotoPage("胸牌或执业证书",doctor.zyz_uri);
                        },
                      )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
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
                          Text("职业资格证书",style: TextStyle(fontSize: 18),),
//                          Text("请上传清晰的免冠证件照",style: TextStyle(color: Colors.grey,fontSize: 14),)
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
                            child: doctor.zgz_uri==null||doctor.zgz_uri==""?Text("尚未上传",style: TextStyle(fontSize: 15,color:Colors.green),):Image.network("${doctor.zgz_uri}")
                        ),
                        onTap:doctor.zgz_uri==null||doctor.zgz_uri==""?(){}:(){
                          toPhotoPage("职业资格证书",doctor.zgz_uri);
                        },
                      )
                  )
                ],
              ),
            ),
            Divider(height: 1,),
            LabelTextRowComponent(label: "审核状态",value: doctor.review=="1"?"已审核":"未审核",),
            Divider(height: 1,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: doctor.review=="1"?RaisedButton(
                color:Theme.of(context).accentColor,
                colorBrightness: Brightness.dark,
                textColor: Colors.white,
                child: Text("审核通过"),
                onPressed: (){

//                    Navigator.pushNamedAndRemoveUntil(context,'/login', (Route<dynamic> route) => false);
//                  });
                },
              ):null,
            ),
          ],
        )
    );
  }
}
