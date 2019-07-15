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
class HistoryNosignPrescriptionComponent extends StatefulWidget {
  Patient patient;
  Prescription prescription;
  List<Medicine> preMedicines;
  Doctor doctor;
  HistoryNosignPrescriptionComponent({this.patient,this.prescription,this.preMedicines,this.doctor});
  @override
  _HistoryNosignPrescriptionComponentState createState() => _HistoryNosignPrescriptionComponentState();
}

class _HistoryNosignPrescriptionComponentState extends State<HistoryNosignPrescriptionComponent> {
 // TextEditingController bqmsController = TextEditingController.fromValue(TextEditingValue(text:"${widget.prescription.bzms}"));//TextEditingController();
  Prescription prescription;
  bool havaSendedToDoctor;
  Doctor doctor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctor=widget.doctor;
    prescription=widget.prescription;
    if (doctor==null){
      havaSendedToDoctor=false;
    }else{
      havaSendedToDoctor=true;
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
      toSelectDoctorPage();
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
          controller:TextEditingController.fromValue(TextEditingValue(text:"${prescription.bzms}")),//bqmsController,
          hintText: "请输入详细疾病描述2-100字",
          isDisplayOnly: true,
        ),
        Divider(height: 1.0,),
        Divider(height: 1.0,),
        Container(
         child: widget.preMedicines.length>0 ? Container(
             height: 30,
             padding: EdgeInsets.only(left: 10.0),
             child: Text("已选处方药", style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor),),
         ):null
        ),
         ListView.builder(
            shrinkWrap:true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:  widget.preMedicines.length,
            //itemExtent: 20,
            itemBuilder: (BuildContext context,int index){
              return PresMedicineRowComponent(index:index+1,medicine:  widget.preMedicines[index],canOper: false,);
            },
          ),
        Divider(height: 1.0,),
        Container(
            padding:EdgeInsets.only(top:5.0) ,
            child: widget.preMedicines.length>0&&!havaSendedToDoctor ?ButtonRowComponent(label:"重新选择医师",callback: onSaved,isEnabled: !havaSendedToDoctor,):null
        ),
        Container(
          child:doctor!=null?DoctorDetailComponent(doctor: doctor,sendToDoctor:sendToDoctor,callDoctor: callDoctor,havaSendedToDoctor: havaSendedToDoctor,isDisplaySendToDoctor: true,):null
        ),
      ],
    );
  }
}
