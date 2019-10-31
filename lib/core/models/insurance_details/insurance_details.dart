/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'insurance_details.g.dart';

/// Holds insurance details of an employee. By using the build_runner script this
/// class generates the insurance_details.g.dart file automatically which is
/// used to serialize the responded json data from the backend safely.
@JsonSerializable()
class InsuranceDetails {
  InsuranceDetails({this.name, this.insuranceNumber, this.socialSecurityNumber});

  factory InsuranceDetails.fromJson(Map<String, dynamic> json) =>
      _$InsuranceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceDetailsToJson(this);

  String name;
  int insuranceNumber;
  int socialSecurityNumber;
}
