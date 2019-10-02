import 'package:json_annotation/json_annotation.dart';
import 'package:time_right/core/models/contract_details/contract_details.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';

part 'home_view_data.g.dart';

@JsonSerializable()
class HomeViewData {
  HomeViewData(
      {this.contractDetails,
      this.stampFails,
      this.currentOverTime,
      this.remainingVacation,
      this.sickDaysMonth,
      this.timeStampDetails});

  factory HomeViewData.fromJson(Map<String, dynamic> json) =>
      _$HomeViewDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomeViewDataToJson(this);

  final ContractDetails contractDetails;
  int stampFails;
  double currentOverTime;
  double remainingVacation;
  double sickDaysMonth;
  List<TimeStampDay> timeStampDetails;
}
