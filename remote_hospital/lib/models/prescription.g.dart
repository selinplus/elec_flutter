// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  return Prescription(
      json['ID'] as int,
      json['bzms'] as String,
      json['patient_name'] as String,
      json['mendian_name'] as String,
      json['yishi_name'] as String,
      json['updated_at'] as String,
      json['cfbm'] as String,
      json['yisqzuri'] as String,
      json['yishi_id'] as int,
      json['yisqzsj'] as String,
      json['cfduri'] as String,
      json['patient_id'] as int,
      json['cfkjsj'] as String);
}
Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'bzms': instance.bzms,
      'patient_name': instance.patient_name,
      'mendian_name': instance.mendian_name,
      'updated_at': instance.updated_at,
      'yishi_name': instance.yishi_name,
      'cfbm': instance.cfbm,
      'yisqzuri': instance.yisqzuri,
      'yishi_id': instance.yishi_id,
      'yisqzsj': instance.yisqzsj,
      'cfduri': instance.cfduri,
      'patient_id': instance.patient_id,
      'cfkjsj': instance.cfkjsj
    };
