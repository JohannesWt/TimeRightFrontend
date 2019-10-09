import 'package:json_annotation/json_annotation.dart';
import 'package:time_right/core/models/address/address.dart';
import 'package:time_right/core/models/bank_details/bank_details.dart';
import 'package:time_right/core/models/career_detail/career_detail.dart';
import 'package:time_right/core/models/company_details/company_details.dart';
import 'package:time_right/core/models/insurance_details/insurance_details.dart';

part 'employee_profile.g.dart';

@JsonSerializable()
class EmployeeProfile {
  EmployeeProfile(
      {this.name,
      this.firstName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.address,
      this.bankDetails,
      this.insuranceDetails,
      this.companyDetails,
      this.careerDetails});

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) =>
      _$EmployeeProfileFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeProfileToJson(this);

  String name;
  String firstName;
  final DateTime dateOfBirth;
  String phoneNumber;
  final String emailAddress;

  final Address address;
  final BankDetails bankDetails;
  final InsuranceDetails insuranceDetails;

// Eventually naming CompanyDetails "DepartmentDetails"
  final CompanyDetails companyDetails;
  final List<CareerDetail> careerDetails;
}
