import 'package:json_annotation/json_annotation.dart';
part 'yaodian.g.dart';
@JsonSerializable()
class Yaodian{
  int ID;
  String mc;
  Yaodian(this.ID, this.mc);
  Yaodian.name();
  factory Yaodian.fromJson(Map<String,dynamic> json) =>_$YaodianFromJson(json);
  Map<String,dynamic> toJson()=>_$YaodianToJson(this);
}