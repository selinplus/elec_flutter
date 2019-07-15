import 'package:flutter/material.dart';
import 'package:remote_hospital/components/doctor_info/doctor_search_component.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './doctor_list_component.dart';
import '../../models/doctor.dart';
class SelectDoctorComponent extends StatefulWidget {
  //SelectDoctorComponent({this.presID});
  @override
  _SelectDoctorComponentState createState() => _SelectDoctorComponentState();
}

class _SelectDoctorComponentState extends State<SelectDoctorComponent> {
  List<Doctor> doctorList =List<Doctor>();
  List<Doctor> displayDoctorList=List<Doctor>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDoctorList();
  }
  _initDoctorList(){
    DioUtil().get(true, "/api/v1/yishis",
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
      doctorList.clear();
      print('http response: ${data["code"]}');
      if (data["code"] == 500) {
        Fluttertoast.showToast(
            msg: "没有在线医师",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white
        );
      } else if (data["code"] == 200) {
        print(data);
       Doctor _doctor;
        if (data["data"] is List) {
          for (int i = 0; i < data["data"].length; i++) {
            _doctor = Doctor.fromJson(data["data"][i]);
            doctorList.add(_doctor);
          }
          displayDoctorList=doctorList;
        }
        setState(() {

        });
      } else {
        Fluttertoast.showToast(
            msg: "获取医师列表失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    });
  }
  onSearch(val){
    if (val.trim()==""){
        displayDoctorList=doctorList;
    }else{
        displayDoctorList=doctorList.where((doctor)=>doctor.name==val).toList();
    }
    setState(() {
    });
    print(displayDoctorList);
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Container(
          child:  DoctorSearchComponent(callback: (val)=>onSearch(val),)
        ),
        Flexible(
          child: DoctorListComponent(doctorList: this.displayDoctorList,callback: this._initDoctorList,),
        )
      ],
    );
  }
}
