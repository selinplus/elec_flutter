import 'package:flutter/material.dart';
import 'package:remote_hospital/components/zqdj/search_component.dart';
import 'package:remote_hospital/components/zqdj/wzyh_list_component.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/patient.dart';
class ZqdjComponent extends StatefulWidget {
  @override
  _ZqdjComponentState createState() => _ZqdjComponentState();
}

class _ZqdjComponentState extends State<ZqdjComponent> {
  List<Patient> patientList=List<Patient>();

    void getPatientList(String mobile){
      FocusScope.of(context).requestFocus(FocusNode());
      if(mobile.trim()==""){
        Fluttertoast.showToast(
            msg: "手机号不能为空",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
        patientList.clear();
        setState(() {

        });
        return;
      }
      Map<String,String> params =Map<String,String>();
      params["mobile"]=mobile.trim();
      DioUtil().get(true, "/api/v1/patient/mobile",queryParameters:params,
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
      ).then((data) {
        patientList.clear();
        print('http response: ${data["code"]}');
        if(data["code"]==500){
          Fluttertoast.showToast(
              msg: "没有手机号为$mobile的用户",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
        }else if(data["code"]==200) {
            print(data);
            Patient _pti;
            if(data["data"] is List){
              for(int i=0;i<data["data"].length;i++){
                _pti=Patient.fromJson(data["data"][i]);
                patientList.add(_pti);
              }
            }
          }else{
            Fluttertoast.showToast(
                msg: "获取用户信息失败,${data['code']}: ${data['msg']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
        }
        setState(() {

        });
      });
    }
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child:  SearchComponent(callback:(val)=>getPatientList(val)),
        ),
        Flexible(
          child: WzyhListComponent(this.patientList),
        )
      ],
    );
  }
}

