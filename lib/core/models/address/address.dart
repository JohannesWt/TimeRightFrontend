import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({
    this.street,
    this.houseNr,
    this.postCode,
    this.city
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String street;
  String houseNr;
  String postCode;
  String city;
}
