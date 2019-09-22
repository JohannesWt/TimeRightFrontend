// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) {
  return BankDetails(
      receiver: json['receiver'] as String,
      bankName: json['bankName'] as String,
      iBAN: json['iBAN'] as String,
      validFrom: json['validFrom'] as String);
}

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'receiver': instance.receiver,
      'bankName': instance.bankName,
      'iBAN': instance.iBAN,
      'validFrom': instance.validFrom
    };
