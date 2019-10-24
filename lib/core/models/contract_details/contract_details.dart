/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'contract_details.g.dart';

/// Holds current contract details of an employee. By using the build_runner
/// script this class generates the contract_details.g.dart file automatically,
/// which is used to serialize the responded json data from the backend safely.
@JsonSerializable()
class ContractDetails {
  ContractDetails(
      {this.workHours,
      this.vacation,});

  factory ContractDetails.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailsToJson(this);

  final double workHours;
  final double vacation;
}
