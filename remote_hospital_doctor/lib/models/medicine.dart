import 'package:json_annotation/json_annotation.dart';
part 'medicine.g.dart';
@JsonSerializable()
class Medicine{
  int pres_id;
  int xh;
  int ID;
  String mc;
  String py;
  String style;
  String source;
  int cnt;
  String unit;
  String route;
  String times;
  String yyjl;

  Medicine(this.pres_id,this.xh,this.ID, this.mc, this.py, this.style, this.source, this.cnt,
      this.unit,this.route,this.times,this.yyjl);
  Medicine.name();
  factory Medicine.fromJson(Map<String,dynamic> json) =>_$MedicineFromJson(json);
  Map<String,dynamic> toJson()=>_$MedicineToJson(this);
}
