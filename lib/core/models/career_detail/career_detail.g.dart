// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'career_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CareerDetail _$CareerDetailFromJson(Map<String, dynamic> json) {
  return CareerDetail(
      companyName: json['companyName'] as String,
      department: json['department'] as String,
      workArea: json['workArea'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String);
}

Map<String, dynamic> _$CareerDetailToJson(CareerDetail instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'department': instance.department,
      'workArea': instance.workArea,
      'startDate': instance.startDate,
      'endDate': instance.endDate
    };
