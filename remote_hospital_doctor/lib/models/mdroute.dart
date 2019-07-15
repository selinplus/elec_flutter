import 'package:json_annotation/json_annotation.dart';
part 'mdroute.g.dart';
@JsonSerializable()
class MdRoute {
  String route;
  MdRoute(this.route);
  MdRoute.name();
  factory MdRoute.fromJson(Map<String,dynamic> json) =>_$MdRouteFromJson(json);
  Map<String,dynamic> toJson()=>_$MdRouteToJson(this);
}