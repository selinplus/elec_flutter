import 'package:json_annotation/json_annotation.dart';
part 'prescription.g.dart';
@JsonSerializable()
class Prescription{
   int ID;
   String bzms;
   String patient_name;
   String mendian_name;
   String updated_at;
   String yishi_name;
   String cfbm;
   String yisqzuri;
   int yishi_id;
   String yisqzsj;
   String cfduri;
   int patient_id;
   String cfkjsj;


   Prescription(this.ID,this.bzms, this.patient_name, this.mendian_name,this.yishi_name, this.updated_at,this.cfbm,this.yisqzuri,this.yishi_id,this.yisqzsj,this.cfduri,this.patient_id,this.cfkjsj);
   Prescription.name();
   factory Prescription.fromJson(Map<String,dynamic> json) =>_$PrescriptionFromJson(json);
   Map<String,dynamic> toJson()=>_$PrescriptionToJson(this);

}