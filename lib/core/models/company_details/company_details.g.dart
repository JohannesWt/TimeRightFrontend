// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetails _$CompanyDetailsFromJson(Map<String, dynamic> json) {
  return CompanyDetails(
      companyName: json['companyName'] as String,
      department: json['department'] == null
          ? null
          : Department.fromJson(json['department'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CompanyDetailsToJson(CompanyDetails instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'department': instance.department
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
      positionDescription: json['positionDescription'] as String,
      executiveID: json['executiveID'] as int,
      executiveName: json['executiveName'] as String,
      departmentName: json['departmentName'] as String,
      departmentID: json['departmentID'] as int);
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'positionDescription': instance.positionDescription,
      'executiveID': instance.executiveID,
      'executiveName': instance.executiveName,
      'departmentName': instance.departmentName,
      'departmentID': instance.departmentID
    };
