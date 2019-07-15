// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
      json['yaodian_id'] as int,
      json['yaodian_mc'] as String,
      json['ID'] as int,
      json['name'] as String,
      json['zydw'] as String,
      json['dept'] as String,
      json['mobile'] as String,
      json['zgzbm'] as String,
      json['zyzbm'] as String,
      json['sfzh'] as String,
      json['jianjie'] as String,
      json['avator_uri'] as String,
      json['zhuangtai'] as String,
      json['username'] as String,
      json['password'] as String,
      json['qz_uri'] as String,
      json['review'] as bool,
      json['zgz_uri'] as String,
      json['zyz_uri'] as String
      );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
  'yaodian_id': instance.yaodian_id,
  'yaodian_mc': instance.yaodian_mc,
  'ID': instance.ID,
  'name': instance.name,
  'zydw': instance.zydw,
  'dept': instance.dept,
  'mobile': instance.mobile,
  'zgzbm': instance.zgzbm,
  'zyzbm': instance.zyzbm,
  'sfzh': instance.sfzh,
  'jianjie': instance.jianjie,
  'avator_uri': instance.avator_uri,
  'zhuangtai': instance.zhuangtai,
  'username': instance.username,
  'password': instance.password,
  'qz_uri': instance.qz_uri,
  'review': instance.review,
  'zgz_uri': instance.zgz_uri,
  'zyz_uri': instance.zyz_uri,
};
