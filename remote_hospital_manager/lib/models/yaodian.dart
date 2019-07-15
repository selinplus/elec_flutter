import 'package:json_annotation/json_annotation.dart';
part 'yaodian.g.dart';
@JsonSerializable()
class Yaodian{
  int ID;
  String mc;
  String username;
  String password;
  Yaodian(this.ID, this.mc,this.username,this.password);
  Yaodian.name();
  factory Yaodian.fromJson(Map<String,dynamic> json) =>_$YaodianFromJson(json);
  Map<String,dynamic> toJson()=>_$YaodianToJson(this);
}