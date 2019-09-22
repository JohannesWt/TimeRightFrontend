// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetails _$CompanyDetailsFromJson(Map<String, dynamic> json) {
  return CompanyDetails(
      name: json['name'] as String,
      position: json['position'] as String,
      supervisorName: json['supervisorName'] as String,
      supervisorID: json['supervisorID'] as String,
      department: json['department'] as String);
}

Map<String, dynamic> _$CompanyDetailsToJson(CompanyDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'supervisorID': instance.supervisorID,
      'supervisorName': instance.supervisorName,
      'department': instance.department
    };
