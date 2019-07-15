import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import 'package:remote_hospital_manager/components/doctor/doctor_info.dart';
import 'package:remote_hospital_manager/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DoctorReviewListComponent extends StatefulWidget {
  @override
  _DoctorReviewListComponentState createState() => _DoctorReviewListComponentState();
}

class _DoctorReviewListComponentState extends State<DoctorReviewListComponent> {
  List<Doctor> doctorList =List<Doctor>();

  void initState(){
    _initDoctorList();
  }
  _initDoctorList(){
    DioUtil().get(true, "/api/v1/yishi/yisrev",
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
            msg: "没有已审核医师",
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
        }
        setState(() {

        });
      } else {
        Fluttertoast.showToast(
            msg: "获取已审核医师列表失败,${data['code']}: ${data['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    });
  }
  Future<void> _onRefresh() async {
    await _initDoctorList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: doctorList.length,
        itemBuilder: (BuildContext context,int index){
          return DoctorInfoComponent(doctor:doctorList[index],callback: _initDoctorList,);
        },
        separatorBuilder: (BuildContext context,int index){
          return Container(
              height: 5,
              color:Colors.grey[100]
          );
        },
      ),
      onRefresh: _onRefresh,
    );
  }
}
