import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/models/medicine.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
import 'package:remote_hospital_doctor/models/mdroute.dart';
import 'package:remote_hospital_doctor/models/mdtimes.dart';
import 'package:remote_hospital_doctor/components/prescription/presMedicine_row_component.dart';
import 'package:intl/intl.dart';
//import 'dart:ui'as ui;
//import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
//import 'package:remote_hospital_doctor/components/prescription/medicine_operation_row.dart';

class HisPrescriptionComponent extends StatefulWidget {
  Doctor doctor;
  Prescription prescription;
  Patient patient;
  List<Medicine> preMedicine;
  HisPrescriptionComponent({this.prescription,this.patient,this.doctor,this.preMedicine});
  @override
  _HisPrescriptionComponentState createState() => _HisPrescriptionComponentState();
}

class _HisPrescriptionComponentState extends State<HisPrescriptionComponent> {

  List<Medicine> presMedicine =List<Medicine>();
  List<MdRoute> mdrouteList = List<MdRoute>();
  List<MdTimes> mdtimesList =List<MdTimes>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DioUtil().get(true,"/api/v1/medicinetype/mdroute",errorCallback: (statuscode){
      Fluttertoast.showToast(
          msg: 'http error code :$statuscode',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
    }).then((data){
      print('http response: ${data["code"]}');
      if(data["code"]==200){
        MdRoute _mdroute ;
        if(data["data"] is List){
          for (int i = 0; i < data["data"].length; i++) {
            _mdroute = MdRoute.fromJson(data["data"][i]);
            mdrouteList.add(_mdroute);
          }
          DioUtil().get(true,"/api/v1/medicinetype/mdtimes",errorCallback: (statuscode){
            Fluttertoast.showToast(
                msg: 'http error code :$statuscode',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor:Colors.red,
                textColor: Colors.white
            );
          }).then((val){
            print(val);
            if(val["code"]==200) {
              MdTimes _mdtimes;
              if (val["data"] is List) {
                for (int i = 0; i < val["data"].length; i++) {
                  _mdtimes = MdTimes.fromJson(val["data"][i]);
                  mdtimesList.add(_mdtimes);
                }
                setState(() {
                });
              }
            }else{
              Fluttertoast.showToast(
                  msg: "给药次数列表获取失败,${data['code']}: ${data['msg']}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor:Colors.red,
                  textColor: Colors.white
              );
            }
          });
        }else{
          Fluttertoast.showToast(
              msg: "给药途径列表获取失败,${data['code']}: ${data['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor:Colors.red,
              textColor: Colors.white
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.prescription.cfduri!=null&&widget.prescription.cfduri!=""?Center(
      child: Image.network(widget.prescription.cfduri),
    ):Container(
          width: 340,
          color:Colors.white,
          child: ListView(
            children: <Widget>[
              Center(
                child: Text("${widget.doctor.zydw}处方签",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
              ),
              Container(
                child:Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top:10.0,left:5.0),
                      alignment: Alignment.bottomLeft,
                      child: Text("诊疗性质：复诊",style: TextStyle(fontSize: 10),),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:10.0,right:5.0),
                      alignment: Alignment.bottomRight,
                      child: Text("处方编号：${widget.prescription.cfbm}",style: TextStyle(fontSize: 10),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0,top:2.0,bottom: 2.0),
                child:  Divider(height: 1.0,),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text("姓名：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width: 50,
                      child: Text("${widget.patient.name}",style: TextStyle(fontSize: 10),),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("性别：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width: 20,
                      child: Text(widget.patient.sex=="1"?"男":"女",style: TextStyle(fontSize: 10),),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("年龄：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width: 30,
                      child: Text("${widget.patient.age}岁",style: TextStyle(fontSize: 10),),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("体重：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width: 40,
                      child: widget.patient.weight==null||widget.patient.weight==""?Text("",style: TextStyle(fontSize: 10),):Text("${widget.patient.weight}kg",style: TextStyle(fontSize: 10),),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0,top:5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text("科别：",style: TextStyle(fontSize: 10),),
                    ),
                    Expanded(
                      child:  Container(
//                        width: 120,
                        child: Text("${widget.doctor.dept}",style: TextStyle(fontSize: 10),),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color:Colors.black)
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: widget.patient.sfzh==null||widget.patient.sfzh==""?null:Text("身份证号：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width: 120,
                      child: widget.patient.sfzh==null||widget.patient.sfzh==""?null:Text("${widget.patient.sfzh}",style: TextStyle(fontSize: 10),),
                      decoration: widget.patient.sfzh==null||widget.patient.sfzh==""?null:BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0,top:5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text("临床诊断：",style: TextStyle(fontSize: 10),),
                    ),
                    Expanded(
                      child:  Container(
//                        width: 160,
                        child: Text("${widget.prescription.bzms}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color:Colors.black)
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("开具时间：",style: TextStyle(fontSize: 10),),
                    ),
                    Container(
                      width:60,
                      child: Text("${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.prescription.updated_at)).toString()}",style: TextStyle(fontSize: 10),),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color:Colors.black)
                          )
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0,top:5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text("住址/电话：",style: TextStyle(fontSize: 10),),
                    ),
                    Expanded(
                      child:  Container(
//                        width: 270,
                        child: Text("${widget.patient.address}  ${widget.patient.mobile}",style: TextStyle(fontSize: 10),),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color:Colors.black)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0,top:2.0,bottom: 2.0),
                child:  Divider(height: 1.0),
              ),

              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                child: Text("Rp:",style: TextStyle(fontSize: 12,color: Colors.grey),),
              ),
              Container(
                height: 210,
                child: ListView.builder(
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.preMedicine.length,
                  //itemExtent: 3,
                  itemBuilder: (BuildContext context,int index){
                    return PresMedicineRowComponent(
                      index:index+1,
                      medicine: widget.preMedicine[index],
//                      callback: (val)=>val,
//                      increment: (val)=>val,
//                      reduce:(val)=>val,
                      canOper: false,
//                      changeMdRoute: (val,index)=>changeMdRoute(val, index),
//                      changeMdTimes: (val,index)=>changeMdTimes(val, index),
//                      changeYyjl: (val,index)=>changeYyjl(val,index),
                      mdrouteList: mdrouteList,
                      mdtimesList: mdtimesList,);
                  },
                ),
              ),
              Container(
                child: Divider(height: 1.0,),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                child: Text("提醒：医师处方仅开具当日有效（医师注明除外）;",style: TextStyle(fontSize: 10,color: Colors.grey),),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                child: Text("            服用抗生素类期间及治疗结束后72小时内，应禁止饮酒或摄入含酒精饮料",style: TextStyle(fontSize: 10,color: Colors.grey),),
              ),
//              Container(
//                padding: EdgeInsets.only(left: 5.0,right: 5.0),
//                child: Text("            。",style: TextStyle(fontSize: 10,color: Colors.grey),),
//              ),
              Container(
                child: Divider(height: 1.0,),
              ),
              Container(
                  padding:EdgeInsets.only(top: 10.0),
                  child:widget.prescription.yisqzuri==null||widget.prescription.yisqzuri==""?null:Row(
                    children: <Widget>[
                      Container(
                        child: Text("医师：",style: TextStyle(fontSize: 10,color:Colors.grey),),
                        alignment: Alignment.centerLeft,
                        width: 40,
                        margin: EdgeInsets.only(left: 30.0,right: 5.0),
                      ),
                      Container(
                        height: 20,
                        width: 40,
                        child: Image.network("${widget.prescription.yisqzuri}"),
                      ),
                    ],
                  )
              ),
            ],
          ),
        );
  }
}

