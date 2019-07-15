import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';
@JsonSerializable()
class Doctor{
     int ID;
     String name;
     String zydw;
     String dept;
     String jianjie;
     String avator_uri;
     String zhuangtai;
     bool review;

     Doctor(this.ID, this.name, this.zydw, this.dept,this.jianjie, this.avator_uri,this.zhuangtai,this.review);
     Doctor.name();
     factory Doctor.fromJson(Map<String,dynamic> json) =>_$DoctorFromJson(json);
     Map<String,dynamic> toJson()=>_$DoctorToJson(this);
}