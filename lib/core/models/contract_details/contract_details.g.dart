// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetails _$ContractDetailsFromJson(Map<String, dynamic> json) {
  return ContractDetails(
      workHours: (json['workHours'] as num)?.toDouble(),
      vacationDays: (json['vacationDays'] as num)?.toDouble());
}

Map<String, dynamic> _$ContractDetailsToJson(ContractDetails instance) =>
    <String, dynamic>{
      'workHours': instance.workHours,
      'vacationDays': instance.vacationDays
    };
