// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      street: json['street'] as String,
      houseNr: json['houseNr'] as String,
      postCode: json['postCode'] as String,
      city: json['city'] as String);
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'houseNr': instance.houseNr,
      'postCode': instance.postCode,
      'city': instance.city
    };
