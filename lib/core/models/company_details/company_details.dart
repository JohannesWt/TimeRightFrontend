/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:json_annotation/json_annotation.dart';

part 'company_details.g.dart';

/// Holds current company details of an employee. By using the build_runner
/// script this class generates the company_details.g.dart file automatically,
/// which is used to  serialize the responded json data from the backend safely.
@JsonSerializable()
class CompanyDetails {
  CompanyDetails({
    this.companyName,
    this.department,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDetailsToJson(this);

  final String companyName;
  final Department department;
}

@JsonSerializable()
class Department {
  Department(
      {this.positionDescription,
      this.executiveID,
      this.executiveName,
      this.departmentName,
      this.departmentID});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);

  final String positionDescription;
  final int executiveID;
  final String executiveName;
  final String departmentName;
  final int departmentID;
}
