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
      supervisorID: json['supervisorID'] as String,
      supervisorName: json['supervisorName'] as String,
      departmentName: json['departmentName'] as String,
      departmentID: json['departmentID'] as String);
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'positionDescription': instance.positionDescription,
      'supervisorID': instance.supervisorID,
      'supervisorName': instance.supervisorName,
      'departmentName': instance.departmentName,
      'departmentID': instance.departmentID
    };
