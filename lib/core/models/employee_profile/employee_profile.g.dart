// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeProfile _$EmployeeProfileFromJson(Map<String, dynamic> json) {
  return EmployeeProfile(
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      phoneNumber: json['phoneNumber'] as int,
      emailAdress: json['emailAdress'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetails.fromJson(json['bankDetails'] as Map<String, dynamic>),
      insuranceDetails: json['insuranceDetails'] == null
          ? null
          : InsuranceDetails.fromJson(
              json['insuranceDetails'] as Map<String, dynamic>),
      companyDetails: json['companyDetails'] == null
          ? null
          : CompanyDetails.fromJson(
              json['companyDetails'] as Map<String, dynamic>),
      careerDetails: (json['careerDetails'] as List)
          ?.map((e) => e == null
              ? null
              : CareerDetail.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$EmployeeProfileToJson(EmployeeProfile instance) =>
    <String, dynamic>{
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'emailAdress': instance.emailAdress,
      'address': instance.address,
      'bankDetails': instance.bankDetails,
      'insuranceDetails': instance.insuranceDetails,
      'companyDetails': instance.companyDetails,
      'careerDetails': instance.careerDetails
    };
