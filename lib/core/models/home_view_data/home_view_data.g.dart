// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeViewData _$HomeViewDataFromJson(Map<String, dynamic> json) {
  return HomeViewData(
      contractDetails: json['contractDetails'] == null
          ? null
          : ContractDetails.fromJson(
              json['contractDetails'] as Map<String, dynamic>),
      stampFails: json['stampFails'] as int,
      currentOverTime: (json['currentOverTime'] as num)?.toDouble(),
      remainingVacation: (json['remainingVacation'] as num)?.toDouble(),
      sickDaysMonth: (json['sickDaysMonth'] as num)?.toDouble(),
      timeStampDetails: (json['timeStampDetails'] as List)
          ?.map((e) => e == null
              ? null
              : TimeStampDay.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HomeViewDataToJson(HomeViewData instance) =>
    <String, dynamic>{
      'contractDetails': instance.contractDetails,
      'stampFails': instance.stampFails,
      'currentOverTime': instance.currentOverTime,
      'remainingVacation': instance.remainingVacation,
      'sickDaysMonth': instance.sickDaysMonth,
      'timeStampDetails': instance.timeStampDetails
    };
