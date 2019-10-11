// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetails _$ContractDetailsFromJson(Map<String, dynamic> json) {
  return ContractDetails(
      workHours: (json['workHours'] as num)?.toDouble(),
      vacation: (json['vacation'] as num)?.toDouble());
}

Map<String, dynamic> _$ContractDetailsToJson(ContractDetails instance) =>
    <String, dynamic>{
      'workHours': instance.workHours,
      'vacation': instance.vacation
    };
