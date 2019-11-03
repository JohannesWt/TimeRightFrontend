// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceDetails _$InsuranceDetailsFromJson(Map<String, dynamic> json) {
  return InsuranceDetails(
      insuranceName: json['insuranceName'] as String,
      insuranceNumber: json['insuranceNumber'] as int,
      socialSecurityNumber: json['socialSecurityNumber'] as int);
}

Map<String, dynamic> _$InsuranceDetailsToJson(InsuranceDetails instance) =>
    <String, dynamic>{
      'insuranceName': instance.insuranceName,
      'insuranceNumber': instance.insuranceNumber,
      'socialSecurityNumber': instance.socialSecurityNumber
    };
