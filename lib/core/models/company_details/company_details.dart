import 'package:json_annotation/json_annotation.dart';

part 'company_details.g.dart';

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
      this.supervisorID,
      this.supervisorName,
      this.departmentName,
      this.departmentID});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);

  final String positionDescription;
  final String supervisorID;
  final String supervisorName;
  final String departmentName;
  final String departmentID;
}
