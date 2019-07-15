// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
      json['ID'] as int,
      json['name'] as String,
      json['married'] as String,
      json['sex'] as String,
      json['sfzh'] as String,
      json['address'] as String,
      json['age'] as int,
      json['regtime'] as String,
      json['mendian_id'] as int,
      json['ywgms'] as String,
      json['weight'] as String,
      json['birthday'] as String,
      json['mobile'] as String);
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'ID': instance.ID,
      'name': instance.name,
      'married': instance.married,
      'sex': instance.sex,
      'sfzh': instance.sfzh,
      'address': instance.address,
      'age': instance.age,
      'regtime': instance.regtime,
      'mendian_id': instance.mendian_id,
      'ywgms': instance.ywgms,
      'weight': instance.weight,
      'birthday': instance.birthday,
      'mobile': instance.mobile
    };
