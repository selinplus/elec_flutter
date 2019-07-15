import 'package:json_annotation/json_annotation.dart';
part 'mdtimes.g.dart';
@JsonSerializable()
class MdTimes {
  String times;
  MdTimes(this.times);
  MdTimes.name();
  factory MdTimes.fromJson(Map<String,dynamic> json) =>_$MdTimesFromJson(json);
  Map<String,dynamic> toJson()=>_$MdTimesToJson(this);
}