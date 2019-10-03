// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetails _$EmployeeDetailsFromJson(Map<String, dynamic> json) {
  return EmployeeDetails(
      contractDetails: json['contractDetails'] == null
          ? null
          : ContractDetails.fromJson(
              json['contractDetails'] as Map<String, dynamic>),
      stampFailsSum: json['stampFailsSum'] as int,
      currentWorkDetails: json['currentWorkDetails'] == null
          ? null
          : CurrentWorkDetails.fromJson(
              json['currentWorkDetails'] as Map<String, dynamic>),
      timeStampDetails: (json['timeStampDetails'] as List)
          ?.map((e) => e == null
              ? null
              : TimeStampDay.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$EmployeeDetailsToJson(EmployeeDetails instance) =>
    <String, dynamic>{
      'contractDetails': instance.contractDetails,
      'stampFailsSum': instance.stampFailsSum,
      'currentWorkDetails': instance.currentWorkDetails,
      'timeStampDetails': instance.timeStampDetails
    };

CurrentWorkDetails _$CurrentWorkDetailsFromJson(Map<String, dynamic> json) {
  return CurrentWorkDetails(
      currentOverTime: (json['currentOverTime'] as num)?.toDouble(),
      remainingVacation: (json['remainingVacation'] as num)?.toDouble(),
      sickDaysMonth: (json['sickDaysMonth'] as num)?.toDouble());
}

Map<String, dynamic> _$CurrentWorkDetailsToJson(CurrentWorkDetails instance) =>
    <String, dynamic>{
      'currentOverTime': instance.currentOverTime,
      'remainingVacation': instance.remainingVacation,
      'sickDaysMonth': instance.sickDaysMonth
    };
