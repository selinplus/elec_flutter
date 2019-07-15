import 'package:json_annotation/json_annotation.dart';
part 'syff.g.dart';
@JsonSerializable()
class Syff {
  String syff_dm;
  String syff_mc;
  Syff(this.syff_dm, this.syff_mc);
  Syff.name();
  factory Syff.fromJson(Map<String,dynamic> json) =>_$SyffFromJson(json);
  Map<String,dynamic> toJson()=>_$SyffToJson(this);
}