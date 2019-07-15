import 'package:flutter/material.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/models/prescription.dart';
import 'package:remote_hospital/components/history_prescription/history_send_pres_component.dart';
import 'package:remote_hospital/services/pref_util.dart';
class HistorySendPresListComponent extends StatefulWidget {
//  Mendian mendian;
//  MdPresListComponent({this.mendian});
  @override
  _HistorySendPresListComponentState createState() => _HistorySendPresListComponentState();
}

class _HistorySendPresListComponentState extends State<HistorySendPresListComponent> {
  List<Prescription> prescriptions =List<Prescription>();
  Mendian mendian =Mendian.name();
  void _getPres() {
    Prescription _p;
    Map<String,int> params = Map<String,int>();
    int mdid;
    getPrefInt("mdid").then((result){
      mdid=result;
      print("mdid:"+mdid.toString());
      mendian.ID=mdid;
      params["id"]=mendian.ID;
      DioUtil().get(true,"/api/v1/prescription/cfmdyis",queryParameters: params,errorCallback: (statuscode){
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
        print('http response: ${data["code"]}');
        print(data);
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
            return HistorySendPresComponent( mendian:mendian,prescription:prescriptions[index],refresh:_getPres,);
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
