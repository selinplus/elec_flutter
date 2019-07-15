import 'package:flutter/material.dart';
import 'package:remote_hospital/screens/qz_page.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/models/doctor.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/models/patient.dart';
import 'package:remote_hospital/models/mdroute.dart';
import 'package:remote_hospital/models/mdtimes.dart';
import 'package:remote_hospital/components/md_prescription/md_presMedicine_row_component.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:remote_hospital/screens/scrawlpage.dart';
import 'package:remote_hospital/services/image_upload_util.dart';
import 'package:remote_hospital/models/prescription.dart';
import 'package:remote_hospital/components/md_prescription/medicine_operation_row.dart';
import 'package:remote_hospital/screens/medicine_page.dart';
class MdPrescriptionComponent extends StatefulWidget {
  Doctor doctor;
  Mendian mendian;
  Prescription prescription;
  Patient patient;
  List<Medicine> preMedicine;
  MdPrescriptionComponent({this.mendian,this.prescription,this.patient,this.doctor,this.preMedicine});
  @override
  _MdPrescriptionComponentState createState() => _MdPrescriptionComponentState();
}

class _MdPrescriptionComponentState extends State<MdPrescriptionComponent> {
  var  widgetsBinding;
  List<Medicine> presMedicine =List<Medicine>();
  List<MdRoute> mdrouteList = List<MdRoute>();
  List<MdTimes> mdtimesList =List<MdTimes>();
 // ui.Image _img;

  String yaoshiqz_uri;
  String tpys_uri;
  String fhys_uri;
  String shys_uri;
  String yaossh_uri;
  String cfd_uri;
  GlobalKey _globalKey =GlobalKey();
  //Medicine presMedicine = Medicine.name();
  bool canOper=false;
  bool canSign=true;
  bool saveTaped=false;
  bool hasCaptured =false;
 // Map syffMap =Map();
  _qz(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return QzPage();
    },)).then((url){
      if(url!=null){
        setState(() {
          yaoshiqz_uri=url;
          if(yaossh_uri!=null&&yaossh_uri!=""&&yaoshiqz_uri!=null&&yaoshiqz_uri!=""&&tpys_uri!=null&&tpys_uri!=""&&fhys_uri!=null&&fhys_uri!=""){
            canSign=false;
          }
        });
      }
    });
  }

  _shqz(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return QzPage();
    },)).then((url){
      if(url!=null){
        setState(() {
          yaossh_uri=url;
          if(yaossh_uri!=null&&yaossh_uri!=""&&yaoshiqz_uri!=null&&yaoshiqz_uri!=""&&tpys_uri!=null&&tpys_uri!=""&&fhys_uri!=null&&fhys_uri!=""){
            canSign=false;
          }
        });
      }
    });
  }
  _tpysqz(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return QzPage();
    },)).then((url){
      if(url!=null){
        setState(() {
          tpys_uri=url;
          if(yaossh_uri!=null&&yaossh_uri!=""&&yaoshiqz_uri!=null&&yaoshiqz_uri!=""&&tpys_uri!=null&&tpys_uri!=""&&fhys_uri!=null&&fhys_uri!=""){
            canSign=false;
          }
        });
      }
    });
  }
  _fhysqz(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return QzPage();
    },)).then((url){
      if(url!=null){
        setState(() {
          fhys_uri=url;
          if(yaossh_uri!=null&&yaossh_uri!=""&&yaoshiqz_uri!=null&&yaoshiqz_uri!=""&&tpys_uri!=null&&tpys_uri!=""&&fhys_uri!=null&&fhys_uri!=""){
            canSign=false;
          }
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cfd_uri=widget.prescription.cfduri;
    widgetsBinding =WidgetsBinding.instance;
    widgetsBinding .addPostFrameCallback((callback){
      widgetsBinding.addPersistentFrameCallback((callback){
        //触发一帧的绘制
        if((cfd_uri==null||cfd_uri=="")&&saveTaped&&!hasCaptured){
          hasCaptured=true;
          print("0000000000000000");
          //print(MediaQuery.of(context).devicePixelRatio.toString());
          if(mounted){
            RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
            upLoadPng(boundary,MediaQuery.of(context).devicePixelRatio,fail: (){
              Fluttertoast.showToast(
                  msg: '生成处方单失败',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white
              );
            }).then((val){
              if(val!=null){
                cfd_uri=val;
                Map<String ,dynamic> params = Map<String,dynamic>();
                params["id"]=widget.prescription.ID;
                //params["yaoshi_id"]=0;
                params["yaosshuri"]=yaossh_uri;
                params["yaosfyuri"]=yaoshiqz_uri;
                params["fhys_uri"]=fhys_uri;
                params["tpys_uri"]=tpys_uri;
                params["cfduri"]=val;
                DioUtil().postWithJson(true, "/api/v1/prescription/editpreyaos",data:params,errorCallback: (statuscode){
                  Fluttertoast.showToast(
                      msg: 'http error code :$statuscode',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor:Colors.red,
                      textColor: Colors.white
                  );
                }).then((data){
                  if(data["code"]==200){
                    Fluttertoast.showToast(
                        msg: '处方单生成成功',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white
                    );
                    setState(() {
                    });
                  }else{
                    Fluttertoast.showToast(
                        msg: "处方单生成失败,${data['code']}: ${data['msg']}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor:Colors.red,
                        textColor: Colors.white
                    );
                    setState(() {
                      cfd_uri=null;
                    });
                  }
                });

              }else{
                print("error");
              }
            });
          }
        }
      });


    });
    presMedicine=widget.preMedicine;
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
//          setState(() {
//          });
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
  changeMdRoute(val,index){
     print(index.toString());
     print(val);
     setState(() {
       presMedicine[index].route=val;
     });
  }
  changeMdTimes(val,index){
    print(index.toString());
    print(val);
    setState(() {
      presMedicine[index].times=val;
    });
  }

  _enterMedicine(){
    if(presMedicine.length==5){
      Fluttertoast.showToast(
          msg: '一张处方单最多只能开5个处方药',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return MedicinePage();
    },)).then((val){
      FocusScope.of(context).requestFocus(FocusNode());
      if(val!=null){
        val.cnt=1;
        setState(() {
          presMedicine.add(val);
        });

      }
    });
  }
  removePresMedicine(val){
    setState(() {
      presMedicine.remove(val);
    });
  }

  void increment(index){
    setState(() {
      presMedicine[index].cnt++;
    });
    print( presMedicine[index].cnt);
  }
  void reduce(index){
    if(presMedicine[index].cnt>1){
      setState(() {
        presMedicine[index].cnt--;
      });
    }
  }
  void changeYyjl(val,index){
    print(index.toString());
    print(val);
//    setState(() {
      presMedicine[index].yyjl=val;
//    });
  }


  _save()  {
     setState(() {
      saveTaped=true;
    });

  }
  _cancel(){
     setState(() {
       yaoshiqz_uri=null;
       tpys_uri=null;
       fhys_uri=null;
       canSign=true;
     });
  }
  @override
  Widget build(BuildContext context) {
    return cfd_uri!=null&&cfd_uri!=""?Center(
      child: Image.network(cfd_uri),
    ):RepaintBoundary(
        key:_globalKey,
        child:Container(
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
                      child: Container(
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
                      child: Text("${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.prescription.yisqzsj)).toString()}",style: TextStyle(fontSize: 10),),
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
                      child:Container(
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
              height: canOper?null:210,
              child: ListView.builder(
               shrinkWrap:true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: presMedicine.length,
               //itemExtent: 3,
               itemBuilder: (BuildContext context,int index){
                 return MdPresMedicineRowComponent(
                   index:index+1,
                   medicine: presMedicine[index],
                   callback: (val)=>removePresMedicine(val),
                   increment: (val)=>increment(val),
                   reduce:(val)=>reduce(val),
                   canOper: canOper,
                   changeMdRoute: (val,index)=>changeMdRoute(val, index),
                   changeMdTimes: (val,index)=>changeMdTimes(val, index),
                   changeYyjl: (val,index)=>changeYyjl(val,index),
                   mdrouteList: mdrouteList,
                   mdtimesList: mdtimesList,);
               },
             ),
            ),
              Container(
                child:!canOper? null:MedOperRow(callback: this._enterMedicine,canPer: canOper,lable: "添加处方药",),
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
              child: Text("            服用抗生素类期间及治疗结束后72小时内，应禁止饮酒或摄入含酒精饮料。",style: TextStyle(fontSize: 10,color: Colors.grey),),
            ),
//            Container(
//              padding: EdgeInsets.only(left: 5.0,right: 5.0),
//              child: Text("            ",style: TextStyle(fontSize: 10,color: Colors.grey),),
//            ),
              Container(
                child: Divider(height: 1.0,),
              ),
              Container(
                padding:EdgeInsets.only(top: 10.0),
                child:widget.prescription.yisqzuri==null?null:Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: Text("审核药师：",style: TextStyle(fontSize: 10,color:Colors.grey),),
                      alignment: Alignment.centerLeft,
                      width: 60,
                      margin: EdgeInsets.only(left: 30.0,right: 5.0),
                    ),
                    Container(
                      height: 20,
                      width: 40,
                      //child:Image.network("${widget.mendian.yaosshuri}"),
                      child:yaossh_uri==null||yaossh_uri==""?null:Image.network("${yaossh_uri}"),
                      margin: EdgeInsets.only(right: 30.0),
                    )
                  ],
                )
              ),
              Container(
                  padding:EdgeInsets.only(top: 10.0),
                  child:Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text("调配核对：",style: TextStyle(fontSize: 10,color:Colors.grey),),
                        alignment: Alignment.centerLeft,
                        width:60,
                        margin: EdgeInsets.only(left: 30.0,right: 5.0),
                      ),
                      Container(
                        height: 20,
                        width: 40,
                        child: tpys_uri==null||tpys_uri==""?null:Image.network("${tpys_uri}"),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        child: Text("复核：",style: TextStyle(fontSize: 10,color:Colors.grey),),
                        alignment: Alignment.centerLeft,
                        width: 40,
                        margin: EdgeInsets.only(left: 30.0,right: 5.0),
                      ),
                      Container(
                        height: 20,
                        width: 40,
                        child: fhys_uri==null||fhys_uri==""?null:Image.network("$fhys_uri"),
                        margin: EdgeInsets.only(right: 30.0),
                      )
                    ],
                  )
              ),
              Container(
                  padding:EdgeInsets.only(top: 10.0),
                  child:Row(
                    children: <Widget>[
                      Container(
                        child: Text("发药药师：",style: TextStyle(fontSize: 10,color:Colors.grey),),
                        alignment: Alignment.centerLeft,
                        width: 60,
                        margin: EdgeInsets.only(left: 30.0,right: 5.0),
                      ),
                      Container(
                        height: 20,
                        width: 40,
                        child: yaoshiqz_uri==null||yaoshiqz_uri==""?null:Image.network("$yaoshiqz_uri"),
                      ),
                    ],
                  )
              ),
              Container(
                child: !canSign||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: yaossh_uri==null||yaossh_uri==""?MedOperRow(callback: _shqz,canPer: true,lable: "审核签字",):null,
                    ),
                  ],
                ),
              ),
              Container(
                child: !canSign||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: (tpys_uri==null||tpys_uri=="")&&yaossh_uri!=null&&yaossh_uri!=""?MedOperRow(callback: _tpysqz,canPer: true,lable: "调配签字",):null,
                    ),
                  ],
                ),
              ),
              Container(
                child: !canSign||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child:(fhys_uri==null||fhys_uri=="")&&tpys_uri!=null&&tpys_uri!=""?MedOperRow(callback: _fhysqz,canPer: true,lable: "复核签字",):null,
                    ),
                  ],
                ),
              ),
              Container(
                child: !canSign||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child:(yaoshiqz_uri==null||yaoshiqz_uri=="")&&fhys_uri!=null&&fhys_uri!=""?MedOperRow(callback: _qz,canPer: true,lable: "发药签字",):null,
                    ),
                  ],
                ),
              ),
              Container(
                child: canSign||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
//                    Container(
//                      child:MedOperRow(callback: _cancel,canPer: true,lable: "取消",),
//                    ),
                    Container(
                      child:MedOperRow(callback: _save,canPer: true,lable: "保存",),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

