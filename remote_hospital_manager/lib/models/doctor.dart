import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';
@JsonSerializable()
class Doctor{
  int yaodian_id;
  String yaodian_mc;
  int ID;
  String name;
  String zydw;
  String dept;
  String mobile;
  String zgzbm;
  String zyzbm;
  String sfzh;
  String jianjie;
  String avator_uri;
  String zhuangtai;
  String username;
  String password;
  String qz_uri;
  bool review;
  String zyz_uri;
  String zgz_uri;


  Doctor(this.yaodian_id, this.yaodian_mc, this.ID, this.name, this.zydw,
      this.dept, this.mobile, this.zgzbm, this.zyzbm, this.sfzh, this.jianjie,
      this.avator_uri, this.zhuangtai,this.username,this.password,this.qz_uri,this.review,this.zgz_uri,this.zyz_uri);
  Doctor.name();
  factory Doctor.fromJson(Map<String,dynamic> json) =>_$DoctorFromJson(json);
  Map<String,dynamic> toJson()=>_$DoctorToJson(this);

}