import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/services/dio_util.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital_doctor/models/prescription.dart';
import 'package:remote_hospital_doctor/components/history_prescription/history_pres_component.dart';
class HistoryNovertifiedPresListComponent extends StatefulWidget {
//  Doctor doctor;
//  HistoryNoververtifiedPresListComponent({this.doctor});
  @override
  _HistoryNovertifiedPresListComponentState createState() => _HistoryNovertifiedPresListComponentState();
}

class _HistoryNovertifiedPresListComponentState extends State<HistoryNovertifiedPresListComponent> {
  List<Prescription> prescriptions =List<Prescription>();
  Doctor doctor =Doctor.name();
 void _getPres(){
     Prescription _p;
     Map<String,int> params = Map<String,int>();
     int doctorid;
     getPrefInt("doctorid").then((result){
       doctorid=result;
       print("doctorid:"+doctorid.toString());
       doctor.ID=doctorid;
       params["id"]=doctor.ID;
       DioUtil().get(true,"/api/v1/prescription/cfyaos",queryParameters: params,errorCallback: (statuscode){
         Fluttertoast.showToast(
             msg: 'http error code :$statuscode',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIos: 1,
             backgroundColor:Colors.red,
             textColor: Colors.white
         );
       }).then((data){
         prescriptions.clear();
         print(data["data"]);
         print('http response: ${data["code"]}');
         if(data["code"]==200){
           Prescription _prescription;
            if(data["data"] is List){
              for (int i = 0; i < data["data"].length; i++) {
                _prescription = Prescription.fromJson(data["data"][i]);
                prescriptions.add(_prescription);
              }
              setState(() {
              });
            }
         }else if(data["code"]==500){
              Fluttertoast.showToast(
                  msg: "没有处方数据",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor:Colors.green,
                  textColor: Colors.white
              );
              setState(() {
              });
            } else{
              Fluttertoast.showToast(
                  msg: "处方列表获取失败,${data['code']}: ${data['msg']}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor:Colors.red,
                  textColor: Colors.white
              );
         }
       });
     });
  }
  Future<void> _onRefresh() async {
    await _getPres();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPres();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child:Container(
        color:Colors.grey[100],
        padding: EdgeInsets.only(left: 5,right: 5,top: 5),
        child: ListView.separated(
          itemCount: prescriptions.length,
          itemBuilder: (BuildContext context,int index){
            return HistoryPresComponent(prescription:prescriptions[index],refresh:_getPres,);
          },
          separatorBuilder: (BuildContext context,int index){
            return Container(
                height: 5,
                color:Colors.grey[100]
            );
          },
        ),
      ),
      onRefresh: _onRefresh,
    );
  }
}
