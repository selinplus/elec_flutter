import 'package:flutter/material.dart';
import './medicine_list_component.dart';
import './medicine_search_component.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/medicine.dart';
class SelectMedicineComponent extends StatefulWidget {
  @override
  _SelectMedicineComponentState createState() => _SelectMedicineComponentState();
}

class _SelectMedicineComponentState extends State<SelectMedicineComponent> {
  List<Medicine> medicineList =List<Medicine>();
  void onSearch(String py){
    FocusScope.of(context).requestFocus(FocusNode());
    if(py.trim()==""){
      Fluttertoast.showToast(
          msg: "药品拼音首写不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
      medicineList.clear();
      setState(() {

      });
      return;
    }
    print(py);
    Map<String,String> params =Map<String,String>();
    params["py"]=py.trim();
    DioUtil().get(true, "/api/v1/medicine/py",queryParameters:params,
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
    ).then((data){
       medicineList.clear();
       print('http response: ${data["code"]}');
       if(data["code"]==500){
         Fluttertoast.showToast(
             msg: "没有拼音首写为$py的药品",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIos: 1,
             backgroundColor: Colors.green,
             textColor: Colors.white
         );
       }else if(data["code"]==200) {
         print(data);
         Medicine _mdcn;
         if(data["data"] is List){
           for(int i=0;i<data["data"].length;i++){
             _mdcn=Medicine.fromJson(data["data"][i]);
             medicineList.add(_mdcn);
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
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Container(
            child:  MedicineSearchComponent(callback:(val) =>onSearch(val))
        ),
        Flexible(
          child: MedicineListComponent(medicineList:this.medicineList),
        )
      ],
    );
  }
}
