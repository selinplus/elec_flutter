// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
      json['ID'] as int,
      json['name'] as String,
      json['zydw'] as String,
      json['dept'] as String,
      json['jianjie'] as String,
      json['avator_uri'] as String,
      json['zhuangtai'] as String,
      json['review'] as bool);
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'ID': instance.ID,
      'name': instance.name,
      'zydw': instance.zydw,
      'dept': instance.dept,
      'jianjie': instance.jianjie,
      'avator_uri': instance.avator_uri,
      'zhuangtai': instance.zhuangtai,
      'review': instance.review
    };
