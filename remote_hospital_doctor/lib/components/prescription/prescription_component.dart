import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/screens/qz_page.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/models/medicine.dart';
import 'package:remote_hospital_doctor/models/mdroute.dart';
import 'package:remote_hospital_doctor/models/mdtimes.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
import 'package:remote_hospital_doctor/components/prescription/presMedicine_row_component.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
import 'package:remote_hospital_doctor/components/prescription/medicine_operation_row.dart';
import 'package:remote_hospital_doctor/screens/medicine_page.dart';
class PrescriptionComponent extends StatefulWidget {
  Doctor doctor;
  Prescription prescription;
  Patient patient;
  List<Medicine> preMedicine;
  PrescriptionComponent({this.doctor,this.prescription,this.patient,this.preMedicine});
  @override
  _PrescriptionComponentState createState() => _PrescriptionComponentState();
}

class _PrescriptionComponentState extends State<PrescriptionComponent> {
  TextEditingController _lczdController = TextEditingController();
  List<Medicine> presMedicine;// =List<Medicine>();
  List<MdRoute> mdrouteList = List<MdRoute>();
  List<MdTimes> mdtimesList =List<MdTimes>();
  String image_uri;
  GlobalKey _globalKey =GlobalKey();
  bool canOper=true;
  bool saveTaped=false;
  _qz(){

    if(_lczdController.text==null||_lczdController.text.trim()==""){
      Fluttertoast.showToast(
          msg: "临床诊断不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    for(int i=0;i<presMedicine.length;i++){
      if(presMedicine[i].yyjl==null||presMedicine[i].yyjl==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药剂量",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
      if(presMedicine[i].times==null||presMedicine[i].times==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药频次",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
      if(presMedicine[i].route==null||presMedicine[i].route==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药途径",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return QzPage();
    },)).then((url){
      if(url!=null){
        setState(() {
          image_uri=url;
          canOper=false;
        });
      }
    });
  }
  _quickQz(){

    if(_lczdController.text==null||_lczdController.text.trim()==""){
      Fluttertoast.showToast(
          msg: "临床诊断不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
      return;
    }
    for(int i=0;i<presMedicine.length;i++){
      if(presMedicine[i].yyjl==null||presMedicine[i].yyjl==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药剂量",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
      if(presMedicine[i].times==null||presMedicine[i].times==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药频次",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
      if(presMedicine[i].route==null||presMedicine[i].route==""){
        Fluttertoast.showToast(
            msg: "请填写["+presMedicine[i].mc+"]的用药途径",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
        return;
      }
    }
    Map<String,int> params = Map<String,int>();
    params["id"]= widget.doctor.ID;
    DioUtil().get(true,"/api/v1/yishi/getyishiqz",queryParameters:params,errorCallback: (statuscode){
      Fluttertoast.showToast(
          msg: 'http error code :$statuscode',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor:Colors.red,
          textColor: Colors.white
      );
    }).then((url){
      print('http response: ${url["code"]}');
      if(url["code"]==200){
        if(url["data"] is List){
          if(url["data"][0] is Map){
            setState(() {
              image_uri=url["data"][0]["qz_uri"];
              canOper=false;
            });
          }
        }
      }else if(url["code"]==500){
        Fluttertoast.showToast(
            msg: "没有已维护的签字信息，请手写签字",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.green,
            textColor: Colors.white
        );
      }else{
        Fluttertoast.showToast(
            msg: "获取签字失败,${url['code']}: ${url['msg']}，请手写签字",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor:Colors.red,
            textColor: Colors.white
        );
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lczdController.text=widget.prescription.bzms;
    presMedicine=widget.preMedicine;
    print(presMedicine);
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
     FocusScope.of(context).requestFocus(FocusNode());
     setState(() {
       presMedicine[index].route=val;
     });
  }
  changeMdTimes(val,index){
    print(index.toString());
    print(val);
    FocusScope.of(context).requestFocus(FocusNode());
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
          backgroundColor:Colors.green,
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
  _save(){
    setState(() {
      saveTaped=true;
    });
     Map<String,dynamic> params = Map<String,dynamic>();
     params["id"]=widget.prescription.ID;
     params["yisqzuri"]=image_uri;
     params["bzms"]=_lczdController.text.trim();
     List<Map<String,dynamic>> _list =List<Map<String,dynamic>>();
     Map<String,dynamic> _medicine;
     for(int i=0;i<presMedicine.length;i++){
       _medicine= Map<String,dynamic>();
       //_medicine["id"]=presMedicine[i].pres_id==null?"":presMedicine[i].pres_id;
       _medicine["id"]=presMedicine[i].ID;
       print(_medicine);
       _medicine["cnt"]=presMedicine[i].cnt;
       print(_medicine);
       _medicine["route"]=presMedicine[i].route==null?"":presMedicine[i].route;
       print(_medicine);
       _medicine["times"]=presMedicine[i].times==null?"":presMedicine[i].times;
       print(_medicine);
       _medicine["yyjl"]=presMedicine[i].yyjl==null?"":presMedicine[i].yyjl;
       print(_medicine);
       _medicine["xh"]=i+1;
       _list.add(_medicine);
     }
     params["Premedicines"]=_list;
     DioUtil().postWithJson(true, "/api/v1/prescription/editpre",data:params,errorCallback: (statuscode){
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
               msg: "保存成功",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIos: 1,
               backgroundColor:Colors.green,
               textColor: Colors.white
           );
         }else{
           Fluttertoast.showToast(
               msg: "保存失败,${data['code']}: ${data['msg']}",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIos: 1,
               backgroundColor:Colors.red,
               textColor: Colors.white
           );
         }
     });

  }
  _cancel(){
    setState(() {
      canOper=true;
      image_uri=null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
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
                      child: Container(
//                        width: 120,
                        child: Text("${widget.doctor.dept}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,),
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
                        child: !canOper?Text("${_lczdController.text}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,):TextField(
                            controller: _lczdController,
                            style: TextStyle(fontSize: 12,color: Theme.of(context).accentColor),
                            decoration: InputDecoration(
                              hintText: "点击输入临床诊断",
                              hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                              //border: InputBorder.none,
                            )
                        ),
                        decoration: canOper?null:BoxDecoration(
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
              height: canOper?null:210,
              child: ListView.builder(
               shrinkWrap:true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: presMedicine.length,
               //itemExtent: 3,
               itemBuilder: (BuildContext context,int index){
                 return PresMedicineRowComponent(
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
//              Container(
//                padding: EdgeInsets.only(left: 5.0,right: 5.0),
//                child: Text("           ",style: TextStyle(fontSize: 10,color: Colors.grey),),
//              ),
              Container(
                child: Divider(height: 1.0,),
              ),
              Container(
                padding:EdgeInsets.only(top: 10.0),
                child:image_uri==null?null:Row(
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
                      child: Image.network("$image_uri"),
                    )
                  ],
                )
              ),
//              Container(
//                child:!canOper||presMedicine.length==0? null:MedOperRow(callback: _qz,canPer: canOper,lable: "签字",),
//              ),
              Container(
                child:!canOper||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child:MedOperRow(callback: _qz,canPer: true,lable: "手写签字",),
                    ),
                    Container(
                      child:MedOperRow(callback: _quickQz,canPer: true,lable: "快速签字",),
                    ),
                  ],
                ),
              ),
              Container(
                child: canOper||saveTaped||presMedicine.length==0? null:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child:MedOperRow(callback: _cancel,canPer: true,lable: "取消",),
                    ),
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

