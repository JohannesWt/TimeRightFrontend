import 'package:json_annotation/json_annotation.dart';

part 'insurance_details.g.dart';

@JsonSerializable()
class InsuranceDetails {
  InsuranceDetails({this.name});

  factory InsuranceDetails.fromJson(Map<String, dynamic> json) =>
      _$InsuranceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceDetailsToJson(this);

  String name;
}
