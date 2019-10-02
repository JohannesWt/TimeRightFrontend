import 'package:json_annotation/json_annotation.dart';

part 'contract_details.g.dart';

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
