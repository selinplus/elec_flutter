import 'package:flutter/material.dart';
import 'package:remote_hospital/components/prescription/ill_description_row.dart';
import 'package:remote_hospital/components/prescription/medicine_operation_row.dart';
import 'package:remote_hospital/components/prescription/presMedicine_row_component.dart';
import 'package:remote_hospital/components/common/button_row_component.dart';
import 'package:remote_hospital/screens/medicine_page.dart';
import 'package:remote_hospital/screens/doctor_page.dart';
import 'package:remote_hospital/models/patient.dart';
import 'package:remote_hospital/models/prescription.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remote_hospital/services/pref_util.dart';
import 'package:remote_hospital/services/dio_util.dart';
import 'package:remote_hospital/components/doctor_info/doctor_detail_component.dart';
import 'package:remote_hospital/screens/video_page.dart';
import '../../models/doctor.dart';
import '../../models/medicine.dart';
class PresComponent extends StatefulWidget {
  Patient patient;
  PresComponent({this.patient});
  @override
  _PresComponentState createState() => _PresComponentState();
}

class _PresComponentState extends State<PresComponent> {
  TextEditingController bqmsController = TextEditingController();
  Prescription prescription =Prescription.name();
  bool isSaved=false;
  bool havaSendedToDoctor =false;
  Doctor doctor;
  List<Medicine> presMedicine =List<Medicine>();
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
  void toSelectDoctorPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return DoctorPage();
    },)).then((val){
      if(val!=null){
        setState(() {
          doctor=val;
        });
      }
    });
  }
  void onSaved(){
    if(isSaved){
      toSelectDoctorPage();
    }else{
      if(bqmsController.text.trim().length<2){
        Fluttertoast.showToast(
            msg: '病情描述不能少2个字!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
        return;
      }
      if(presMedicine.length==0){
        Fluttertoast.showToast(
            msg: '至少需要选择1个处方药',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
        return;
      }
      Map<String,dynamic> map = Map<String,dynamic>();
      List presmedicines = List();
      getPrefInt("mdid").then((val){
        map["mendian_id"]=val;
        map["bzms"]=bqmsController.text.trim();
        map["patient_id"]=widget.patient.ID;
        for(int i =0;i<presMedicine.length;i++){
          presMedicine[i].xh=i+1;
          presmedicines.add(presMedicine[i].toJson());
        }
        map["premedicines"]=presmedicines;
        print(map);
        return DioUtil().postWithJson(true, "/api/v1/prescriptions",data:map,
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
        );
      }).then((data){
        if(data["code"]==200) {
          print(data);
          prescription.ID=data["data"];
          print(prescription.ID.toString());
          setState(() {
            isSaved=true;
          });
          toSelectDoctorPage();
        }else {
          Fluttertoast.showToast(
              msg: "提交处方信息失败,${data['code']}: ${data['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
      });
    }
  }

  sendToDoctor(){
      Map<String,int> params = Map<String,int>();
      params["ID"]=prescription.ID;
      params["yishi_id"]=doctor.ID;
      DioUtil().postWithJson(true, "/api/v1/prescription/yishi",data: params,
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
        print('http response: ${data["code"]}');
        if(data["code"]==200) {
          setState(() {
            this.havaSendedToDoctor=true;
          });
          Fluttertoast.showToast(
              msg: "数据提交成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
          //Navigator.popUntil(context,ModalRoute.withName('/main'));
        }else{
          Fluttertoast.showToast(
              msg: "数据提交失败,${data['code']}: ${data['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor:Colors.red,
              textColor: Colors.white
          );
        }
      });
  }
  callDoctor(){
    print("call doctor");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //指定跳转的页面
      return VideoPage(doctor_id: "doctor"+doctor.ID.toString(),);
    },));
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        IllDesRow(
          label: "病情描述",
          controller:bqmsController,
          hintText: "请输入详细疾病描述2-100字",
          isDisplayOnly: isSaved,
        ),
        Divider(height: 1.0,),
        Container(
          child:isSaved? null:MedOperRow(callback: this._enterMedicine,canPer: !isSaved,),
        ),
        Divider(height: 1.0,),
        Container(
         child:presMedicine.length>0 ? Container(
             height: 30,
             padding: EdgeInsets.only(left: 10.0),
             child: Text("已选处方药", style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor),),
         ):null
        ),
         ListView.builder(
            shrinkWrap:true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: presMedicine.length,
            //itemExtent: 20,
            itemBuilder: (BuildContext context,int index){
              return PresMedicineRowComponent(index:index+1,medicine: presMedicine[index],callback: (val)=>removePresMedicine(val),increment: (val)=>increment(val),reduce:(val)=>reduce(val),canOper: !isSaved,);
            },
          ),
        Divider(height: 1.0,),
        Container(
            padding:EdgeInsets.only(top:5.0) ,
            child:presMedicine.length>0&&!havaSendedToDoctor ?ButtonRowComponent(label:!isSaved? "保存并选择医师":"重新选择医师",callback: onSaved,isEnabled: !havaSendedToDoctor,):null
        ),
        Container(
          child:doctor!=null?DoctorDetailComponent(doctor: doctor,sendToDoctor:sendToDoctor,callDoctor: callDoctor,havaSendedToDoctor: havaSendedToDoctor,isDisplaySendToDoctor: true,):null
        ),
      ],
    );
  }
}
