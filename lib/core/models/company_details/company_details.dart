import 'package:json_annotation/json_annotation.dart';

part 'company_details.g.dart';

@JsonSerializable()
class CompanyDetails {
  CompanyDetails({
    this.name,
    this.position,
    this.supervisorName,
    this.supervisorID,
    this.department,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDetailsToJson(this);

  final String name;
  final String position;
  final String supervisorID;
  final String supervisorName;
  final String department;
}
