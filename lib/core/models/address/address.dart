/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Holds address data of an employee. By using the build_runner script this
/// class generates the address.g.dart file automatically which is used to
/// serialize the responded json data from the backend safely.
@JsonSerializable()
class Address {
  Address({this.street, this.houseNr, this.postCode, this.city});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String street;
  String houseNr;
  String postCode;
  String city;
}
