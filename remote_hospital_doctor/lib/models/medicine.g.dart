// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) {
  return Medicine(
      json['pres_id'] as int,
      json['xh'] as int,
      json['ID'] as int,
      json['mc'] as String,
      json['py'] as String,
      json['style'] as String,
      json['source'] as String,
      json['cnt'] as int,
      json['unit'] as String,
      json['route'] as String,
      json['times'] as String,
      json['yyjl'] as String
  );
}

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      'pres_id': instance.pres_id,
      'xh': instance.xh,
      'ID': instance.ID,
      'mc': instance.mc,
      'py': instance.py,
      'style': instance.style,
      'source': instance.source,
      'cnt': instance.cnt,
      'unit': instance.unit,
      'route': instance.route,
      'times':instance.times,
      'yyjl':instance.yyjl,
    };
