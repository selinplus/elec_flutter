import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
import 'package:remote_hospital_doctor/models/medicine.dart';
import 'package:remote_hospital_doctor/screens/prescription_page.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/screens/patient_details_page.dart';
import 'package:remote_hospital_doctor/screens/his_prescription_page.dart';
class HistoryPresComponent extends StatelessWidget {
  //Doctor doctor;
  Prescription prescription;
  final refresh;
  HistoryPresComponent({this.prescription,this.refresh});
  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          child:  Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 90.0,
//              color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("${prescription.patient_name}",style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor)),
                  ),
                  Expanded(
                      child:Container(
                          height: 40.0,
//              color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text("${prescription.mendian_name}",style: TextStyle(fontSize: 12)),
                      )

                  ),
                  Container(
                    height: 40.0,
                    width: 100.0,
//              color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("${prescription.yisqzsj}",style: TextStyle(fontSize: 12)),
                  )
                ],
              ),
              Divider(height: 1.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: 90.0,
                    height: 40.0,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("病情描述",style: TextStyle(fontSize: 12)),
                  ),
                  Expanded(
                    child:  Container(
//              color: Colors.red,
                      // height: 40,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("${prescription.bzms}",style: TextStyle(fontSize: 12),maxLines: 3,overflow: TextOverflow.ellipsis,),
                    )
                  ),

                ],
              ),
              Divider(height: 1.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    height: 30,
                    width: 80,
                    child:RaisedButton(
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        textColor: Theme
                            .of(context)
                            .accentColor,
                        child: Text("病人详情", style: TextStyle(fontSize: 12)),
                        color: Colors.white,
                        shape: Border.all(
                            color: Theme
                                .of(context)
                                .accentColor,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        onPressed: () {
                          Patient _patient;
                          Map<String,int> params = Map<String,int>();
                          params["id"]=prescription.patient_id;
                          DioUtil().get(true, "/api/v1/patient/info",queryParameters: params,errorCallback: (statuscode){
                            Fluttertoast.showToast(
                                msg: 'http error code :$statuscode',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor:Colors.red,
                                textColor: Colors.white
                            );
                          }).then((val){
                            print('http response: ${val["code"]}');
                            print(val);
                            if (val["code"] == 200) {
                              if(val["data"] is Map){
                                _patient = Patient.fromJson(val["data"]) ;
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  //指定跳转的页面
                                  return PatientDetailsPage(patient: _patient,);
                                },));
                              }
                            }else{
                              Fluttertoast.showToast(
                                  msg: '病人详情获取失败',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor:Colors.red,
                                  textColor: Colors.white
                              );
                            }
                          });
                        }
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(5),
                    height: 30,
                    width: 80,
                    child:RaisedButton(
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        textColor: Theme
                            .of(context)
                            .accentColor,
                        child: Text("进入处方", style: TextStyle(fontSize: 12)),
                        color: Colors.white,
                        shape: Border.all(
                            color: Theme
                                .of(context)
                                .accentColor,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        onPressed: () {
                          Patient patient;
                          Doctor doctor;
                          List<Medicine> preMedicines=List<Medicine>();
                          Map<String,int> params = Map<String ,int>();
                          params["id"]= prescription.ID;
                          DioUtil().get(true,"/api/v1/prescription/cf",queryParameters: params,errorCallback: (statuscode){
                            Fluttertoast.showToast(
                                msg: 'http error code :$statuscode',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor:Colors.red,
                                textColor: Colors.white
                            );
                          }).then((_pres) {
                            print('http response: ${_pres["code"]}');
                            print(_pres);
                            if (_pres["code"] == 200) {
                              if (_pres["data"] is List) {
                                //
                                if (_pres["data"][0] is Map) {

                                  print(_pres["data"][0]);
                                  if(_pres["data"][0] is Map){
                                    print(_pres["data"][0]["Patient"]);
                                    patient = Patient.fromJson(_pres["data"][0]["Patient"]);
                                    doctor =Doctor.fromJson(_pres["data"][0]["Yishi"]);
                                    prescription.cfbm=_pres["data"][0]["cfbm"];
                                    prescription.updated_at=_pres["data"][0]["UpdatedAt"];
                                    prescription.yisqzsj=_pres["data"][0]["yisqzsj"];
                                    prescription.cfduri=_pres["data"][0]["cfduri"];
                                    prescription.yisqzuri=_pres["data"][0]["yisqzuri"];
                                    prescription.bzms=_pres["data"][0]["bzms"];
                                    //print("prescription.updated_at:"+prescription.updated_at);
                                    if(_pres["data"][0]["Premedicines"] is List){
                                      List listPres=_pres["data"][0]["Premedicines"];
                                      Medicine preMedicine,medicine1;
                                      for (int i=0;i<listPres.length;i++){
                                        preMedicine=Medicine.name();
                                        preMedicine.pres_id=listPres[i]["ID"];
                                        preMedicine.cnt=listPres[i]["cnt"];
                                        //preMedicine.xh=listPres[i]["xh"];
                                          preMedicine.yyjl=listPres[i]["yyjl"];
                                          preMedicine.route=listPres[i]["route"];
                                          preMedicine.times=listPres[i]["times"];
                                        if(_pres["data"][0]["Premedicines"][i]["Medicine"] is Map){
                                          medicine1 =Medicine.fromJson(_pres["data"][0]["Premedicines"][i]["Medicine"]);
                                          preMedicine.ID=medicine1.ID;
                                          preMedicine.mc=medicine1.mc;
                                          preMedicine.style=medicine1.style;
                                          preMedicine.unit=medicine1.unit;
                                        }
                                        preMedicines.add(preMedicine);
                                      }

                                    }
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //指定跳转的页面
                                      return HisPrescriptionPage(prescription: prescription,doctor: doctor,patient: patient,preMedicine: preMedicines,);//PrescriptionPage(doctor:doctor,prescription: prescription,patient: patient,preMedicine: preMedicines,);
                                    },)).then((_){
                                      refresh();
                                    });
                                  }

                                }
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: '处方信息获取失败',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor:Colors.red,
                                  textColor: Colors.white
                              );
                            }
                          });
                        }
                    ),
                  ),
                ],
              ),
            ],
          )
      );


  }
}
