import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/patient/label_text_row_component.dart';
import 'package:remote_hospital_doctor/models/patient.dart';
class PatientDetailsComponent extends StatelessWidget {
  Patient patient;
  PatientDetailsComponent({this.patient});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child:   ListView(
        children: <Widget>[
          LabelTextRowComponent(label: "手机号码",value: patient.mobile,),
          Divider(height: 1,),
          LabelTextRowComponent(label: "姓名",value: patient.name,),
          Divider(height: 1,),
          LabelTextRowComponent(label: "性别",value: patient.sex=="1"?"男":"女",),
          Divider(height: 1,),
          LabelTextRowComponent(label: "婚否",value: patient.married=="1"?"已婚":"未婚",),
          Divider(height: 1,),
          LabelTextRowComponent(label: "身份证号",value: patient.sfzh,),
          Divider(height: 1,),
          LabelTextRowComponent(label: "出生日期",value: patient.birthday,),
          Divider(height: 1,),
          LabelTextRowComponent(label: "年龄",value: patient.age==null?"":patient.age.toString()+"岁",),
          Divider(height: 1,),
          LabelTextRowComponent(label: "体重",value: patient.weight==null?"":patient.weight.toString()+"kg",),
          Divider(height: 1,),
          LabelTextRowComponent(label: "药物过敏史",value: patient.ywgms=="1"?"有":patient.ywgms==null?"":"无",),
          Divider(height: 1,),
          LabelTextRowComponent(label: "体重",value: patient.address),
          Divider(height: 1,),
        ],
      )
    );

  }
}
