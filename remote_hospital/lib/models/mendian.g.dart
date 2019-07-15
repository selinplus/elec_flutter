// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mendian.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mendian _$MendianFromJson(Map<String, dynamic> json) {
  return Mendian(
      json['ID'] as int,
      json['mc'] as String,
      json['fzr'] as String,
      json['dianhua'] as String,
      json['licence'] as String,
      json['username'] as String,
      json['password'] as String,
      json['yaodian_id'] as int,
      json['yaodian_mc'] as String,
      json['yaosshuri'] as String,
      json['version'] as String
  );
}

Map<String, dynamic> _$MendianToJson(Mendian instance) => <String, dynamic>{
      'ID': instance.ID,
      'mc': instance.mc,
      'fzr': instance.fzr,
      'dianhua': instance.dianhua,
      'licence': instance.licence,
      'username': instance.username,
      'password': instance.password,
      'yaodian_id': instance.yaodian_id,
      'yaodian_mc': instance.yaodian_mc,
      'yaosshuri': instance.yaosshuri,
      'version': instance.version
    };
