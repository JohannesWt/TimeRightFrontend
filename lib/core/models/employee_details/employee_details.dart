import 'package:json_annotation/json_annotation.dart';
import 'package:time_right/core/models/contract_details/contract_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';

part 'employee_details.g.dart';

@JsonSerializable()
class EmployeeDetails {
  EmployeeDetails({
    this.contractDetails,
    this.stampFailsSum,
    this.currentWorkDetails,
    this.timeStampDetails,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailsToJson(this);

  final ContractDetails contractDetails;
  int stampFailsSum;
  CurrentWorkDetails currentWorkDetails;
  List<TimeStampDay> timeStampDetails;
}

@JsonSerializable()
class CurrentWorkDetails {
  CurrentWorkDetails({
    this.flexTime,
    this.remainingVacation,
    this.remainingVacationLastYear,
    this.appliedVacation,
    this.takenVacation,
    this.sickDaysMonth,
  });

  factory CurrentWorkDetails.fromJson(Map<String, dynamic> json) =>
      _$CurrentWorkDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWorkDetailsToJson(this);

  double flexTime;
  double remainingVacation;
  double remainingVacationLastYear;
  double appliedVacation;
  double takenVacation;
  double sickDaysMonth;
}
