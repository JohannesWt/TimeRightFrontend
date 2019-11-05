/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:time_right/core/models/address/address.dart';
import 'package:time_right/core/models/bank_details/bank_details.dart';
import 'package:time_right/core/models/career_detail/career_detail.dart';
import 'package:time_right/core/models/company_details/company_details.dart';
import 'package:time_right/core/models/insurance_details/insurance_details.dart';

part 'employee_profile.g.dart';

/// Holds the profile data of an employee. By using the build_runner script this
/// class generates the employee_profile.g.dart file automatically file which is
/// used to serialize the responded json data from the backend safely.
@JsonSerializable()
class EmployeeProfile {
  EmployeeProfile(
      {this.lastName,
      this.firstName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAdress,
      this.address,
      this.bankDetails,
      this.insuranceDetails,
      this.companyDetails,
      this.careerDetails});

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) =>
      _$EmployeeProfileFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeProfileToJson(this);

  String lastName;
  String firstName;
  final DateTime dateOfBirth;
  int phoneNumber;
  final String emailAdress;

  final Address address;
  final BankDetails bankDetails;
  final InsuranceDetails insuranceDetails;

// Eventually naming CompanyDetails "DepartmentDetails"
  final CompanyDetails companyDetails;
  final List<CareerDetail> careerDetails;
}
