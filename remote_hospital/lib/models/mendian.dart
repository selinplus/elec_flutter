import 'package:json_annotation/json_annotation.dart';
part 'mendian.g.dart';
@JsonSerializable()
class Mendian{
  int ID;
  String mc;
  String fzr;
  String dianhua;
  String licence;
  String username;
  String password;
  int yaodian_id;
  String yaodian_mc;
  String yaosshuri;
  String version;

  Mendian(this.ID, this.mc, this.fzr, this.dianhua, this.licence,
      this.username, this.password, this.yaodian_id, this.yaodian_mc,this.yaosshuri,this.version);
  Mendian.name();
  factory Mendian.fromJson(Map<String,dynamic> json) =>_$MendianFromJson(json);
  Map<String,dynamic> toJson()=>_$MendianToJson(this);
}