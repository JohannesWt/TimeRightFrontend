/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'bank_details.g.dart';

/// Holds bank details data of an employee. By using the build_runner script
/// this class generates the bank_details.g.dart file automatically which is
/// used to serialize the responded json data from the backend safely.
@JsonSerializable()
class BankDetails {
  BankDetails({this.receiver, this.bankName, this.iban, this.validFrom});

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);

  String receiver;
  String bankName;
  String iban;
  String validFrom;
}
