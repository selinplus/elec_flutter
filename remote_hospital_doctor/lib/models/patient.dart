import 'package:json_annotation/json_annotation.dart';
part 'patient.g.dart';
@JsonSerializable()
class Patient{
  int ID;
  String name;
  String married;
  String sex;
  String sfzh;
  String address;
  int age;
  String regtime;
  int mendian_id;
  String ywgms;
  String weight;
  String birthday;
  String mobile;

  Patient(this.ID, this.name, this.married, this.sex, this.sfzh, this.address,
      this.age, this.regtime, this.mendian_id, this.ywgms, this.weight, this.birthday,
      this.mobile);

  Patient.name();
  factory Patient.fromJson(Map<String,dynamic> json) =>_$PatientFromJson(json);
  Map<String,dynamic> toJson()=>_$PatientToJson(this);
}
